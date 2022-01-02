import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:plato_calendar/Data/ics.dart';
import 'package:plato_calendar/utility.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Data/privateKey.dart';

import '../Data/database/database.dart';
import '../Data/userData.dart';

part 'calendar.g.dart';


void prompt(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class GoogleCalendarToken{
  // AccessCredentials

    //AcessToken
    String type;
    String data;
    DateTime expiry;

  String refreshToken;
  List<String> scopes;
  
  // token 갱신 여부 check하고 update
  Stream<AccessCredentials> tokenStream;
  AccessCredentials token;
  AutoRefreshingAuthClient client;

  /// Google API 통신담당 queue
  /// 
  /// Queue에 Event calendar를 넣으면
  /// 
  /// 0.5초에 하나씩 처리함(Rate Limit Exceeded 방지).
  StreamController<CalendarData> googleAsyncQueue;

  Future<void> closeStream() async {
    await googleAsyncQueue.close();
  }
  // db에서 null 체크하고 null일 경우 UserData.isSaveGoogleToken = false로 변경필요.
  GoogleCalendarToken(
    this.type,
    this.data, 
    this.expiry,
    this.refreshToken,
    this.scopes,
  );

  /// Must call this function after DB restores GoogleCalendarToken Data
  bool restoreAutoRefreshingAuthClient(){
    try{
      if(!UserData.isSaveGoogleToken)
        return false;

      token = AccessCredentials(
        AccessToken(this.type, this.data, this.expiry), 
        this.refreshToken,
        this.scopes);

      client = autoRefreshingClient(
        ClientId(PrivateKey.clientIDIdentifier, ""),
        token, 
        Client());
      
      tokenStream = client.credentialUpdates;
    }
    catch(e){
      notifyDebugInfo(e.toString());
      return false;
    }
    return true;
  }

  Future<bool> authUsingGoogleAccount() async {
    try{
      await clientViaUserConsent(
      ClientId(PrivateKey.clientIDIdentifier, ""), const [CalendarApi.calendarEventsScope] , prompt)
      .then((AutoRefreshingAuthClient newClient) {
        //prompt("app://com.seunggil.plato_calendar/");
        AccessCredentials newToken = newClient.credentials;
        this.type   = newToken.accessToken.type;
        this.data   = newToken.accessToken.data;
        this.expiry = newToken.accessToken.expiry;
        this.refreshToken = newToken.refreshToken;
        this.scopes = newToken.scopes;

        this.tokenStream = newClient.credentialUpdates;
        this.token = newToken;
        this.client = newClient;
      });
      
      UserData.isSaveGoogleToken = true;
      UserData.googleFirstLogin = true;
      await UserData.writeDatabase.googleDataSave();
      await Future.delayed(Duration(seconds: 2));
      // 로그인 완료 후 앱으로 화면 전환이 안됨.
      // 어플 종료 후 다음 실행 때 Google Calendar로 일정 업로드 시작.
      if(Platform.isAndroid)
        SystemNavigator.pop();
      else if(Platform.isIOS)
        exit(0);
    }catch(e){
      notifyDebugInfo(e.toString());
      return false;
    }
      return true;
  }

  Future<void> logOutGoogleAccount() async {
      UserData.isSaveGoogleToken = false;
      this.type = "";
      this.data = ""; 
      this.expiry = DateTime(1990);
      this.refreshToken = "";
      this.scopes = [];
      await UserData.writeDatabase.googleDataSave();
  }

  /// Google Calendar 업데이트를 delayTime 초 마다 한번 씩 진행.
  ///
  /// success면 delayTime이 1초로,
  ///
  /// Fail처리가 될 경우 delayTime이 2의 지수 승으로 증가함.
  int delayTime = 1;

  /// Google Calendar 업데이트를 연속으로 failCount만큼 실패함.
  ///
  /// Fail처리가 될 경우 delayTime이 2의 지수 승으로 증가함.
  int failCount = 0;

  /// asyncQueueSize에 들어있는 데이터 갯수.
  int asyncQueueSize = 0;

  /// google 계정 연동 직후 데이터 전체 Google Calendar로 update
  /// 그 외의 경우 그냥 함수 종료.
  Future<bool> updateCalendarFull() async {
    if(!(UserData.isSaveGoogleToken && UserData.googleFirstLogin))
      return false;
    
    int total = 0;
    DateTime nowTime = DateTime.now();
    
    UserData.data.forEach((CalendarData data) async {
      Duration diff = nowTime.difference(data.end);
      if(!data.disable && !data.finished && diff.inDays <= 5){
        googleAsyncQueue.add(data);
        total++;
        asyncQueueSize++;
      }
    });
    await Future.delayed((Duration(seconds: 1)));
    while(asyncQueueSize != 0){
      showToastMessageCenter("Google 동기화를 진행중입니다. 앱을 종료하지 말아 주세요.(${total-asyncQueueSize}/$total)");
      await Future.delayed((Duration(seconds: 3)));
    }
    UserData.googleFirstLogin = false;
    showToastMessageCenter("Google 동기화 완료!");
    return true;
  }
  Future<bool> updateCalendar(Event newEvent) async{
    if(!UserData.isSaveGoogleToken)
        return true;
    
    try{
      CalendarApi mycalendar = CalendarApi(client);
      List<Event> searchResult = (await mycalendar.events.list("primary", iCalUID: newEvent.iCalUID, showDeleted: true)).items;

      if(searchResult != null && searchResult.length >=1 && searchResult[0].id != null)
        await mycalendar.events.patch(newEvent, "primary", searchResult[0].id);
      else
        await mycalendar.events.insert(newEvent, "primary");
      delayTime = 1;
      failCount = 0;
      return true;
    }catch(e){
      notifyDebugInfo(e.toString());
      failCount += 1;
      delayTime *= 2;
      return false;
    }
    
  }

  Future<bool> deleteCalendar(Event newEvent) async{
    if(!UserData.isSaveGoogleToken)
        return true;

    try{
      CalendarApi mycalendar = CalendarApi(client);
      List<Event> searchResult = (await mycalendar.events.list("primary", iCalUID: newEvent.iCalUID)).items;

      if(searchResult != null && searchResult.length >=1 && searchResult[0].id != null)
        mycalendar.events.delete("primary", searchResult[0].id);
      
      delayTime = 1;
      failCount = 0;

      return true;
    }catch(e){
      notifyDebugInfo(e.toString());
      failCount += 1;
      delayTime *= 2;

      return false;
    }
    
  }
}

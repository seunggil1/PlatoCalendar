import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
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

  // db에서 null 체크하고 null일 경우 enable = false로 변경필요.
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
  Future<bool> updateCalendarFull() async {
    showToastMessageCenter("Google 동기화를 진행중입니다. 앱을 종료하지 말아 주세요.");
    DateTime nowTime = DateTime.now();
    UserData.data.forEach((element) async { 
      Duration diff = nowTime.difference(element.end);
      if(!element.disable && !element.finished && diff.inDays <= 5){
        await updateCalendar(element.toEvent());
        await Future.delayed(const Duration(milliseconds: 300)); // 403 오류 : Rate Limit Exceeded 방지.
      }
    });
    UserData.googleFirstLogin = false;
    showToastMessageCenter("Google 동기화 완료!");
    return true;
  }
  Future<bool> updateCalendar(Event newEvent) async{
    if(!UserData.isSaveGoogleToken)
        return false;

    try{
      CalendarApi mycalendar = CalendarApi(client);
      List<Event> searchResult = (await mycalendar.events.list("primary", iCalUID: newEvent.iCalUID, showDeleted: true)).items;

      if(searchResult != null && searchResult.length >=1 && searchResult[0].id != null)
        await mycalendar.events.patch(newEvent, "primary", searchResult[0].id);
      else
        await mycalendar.events.insert(newEvent, "primary");
      return true;
    }catch(e){
      notifyDebugInfo(e.toString());
      return false;
    }
    
  }

    Future<bool> deleteCalendar(Event newEvent) async{
    if(!UserData.isSaveGoogleToken)
        return false;

    try{
      CalendarApi mycalendar = CalendarApi(client);
      List<Event> searchResult = (await mycalendar.events.list("primary", iCalUID: newEvent.iCalUID)).items;

      if(searchResult != null && searchResult.length >=1 && searchResult[0].id != null)
        mycalendar.events.delete("primary", searchResult[0].id);
      
      return true;
    }catch(e){
      notifyDebugInfo(e.toString());
      return false;
    }
    
  }
}

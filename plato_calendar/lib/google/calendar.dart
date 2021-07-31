import 'package:hive/hive.dart';
import 'package:http/http.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Data/privateKey.dart';

import '../Data/database.dart';
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
      return false;
    }
    return true;
  }

  Future<void> authUsingGoogleAccount() async {
    await clientViaUserConsent(
      ClientId(PrivateKey.clientIDIdentifier, ""), const [CalendarApi.calendarEventsScope] , prompt)
      .then((AutoRefreshingAuthClient newClient) {
        AccessCredentials newToken = newClient.credentials;
        this.type   = newToken.accessToken.type;
        this.data   = newToken.accessToken.data;
        this.expiry = newToken.accessToken.expiry;
        this.refreshToken = newToken.refreshToken;
        this.scopes = newToken.scopes;
      });

      UserData.isSaveGoogleToken = true;
      await Database.googleDataSave();
  }

  Future<void> logOutGoogleAccount() async {
      UserData.isSaveGoogleToken = false;
      this.type = "";
      this.data = ""; 
      this.expiry = DateTime(1990);
      this.refreshToken = "";
      this.scopes = [];
      await Database.googleDataSave();
  }

  Future<bool> updateCalendar(Event newEvent) async{
    if(!UserData.isSaveGoogleToken)
        return false;

    try{
      CalendarApi mycalendar = CalendarApi(client);
      List<Event> searchResult = (await mycalendar.events.list("primary", iCalUID: newEvent.iCalUID)).items;

      if(searchResult != null && searchResult.length >=1 && searchResult[0].id != null)
        mycalendar.events.patch(newEvent, "primary", searchResult[0].id);
      else
        mycalendar.events.insert(newEvent, "primary");
      
      return true;
    }catch(e){
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
      return false;
    }
    
  }
}

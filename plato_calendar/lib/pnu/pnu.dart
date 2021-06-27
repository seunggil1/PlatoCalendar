import '../Data/userData.dart';
import '../main.dart';
import 'onestop.dart';
import 'plato.dart';

Future<bool> update({bool force = false}) async{
  if(UserData.id != ""){
    if(DateTime.now().day != UserData.oneStopLastSyncDay)
      if(await Onestop.login() && await Onestop.getTestTimeTable() && await Onestop.logout()){}
    UserData.oneStopLastSyncDay = DateTime.now().day;

    if(force ||(DateTime.now().difference(UserData.lastSyncTime).inHours > 6)){
      if(await Plato.login() && await Plato.getCalendar() && await Plato.logout()){
        pnuStream.sink.add(true);
        return true;
      }
      return false;
    }
  }
    
  return false;
}
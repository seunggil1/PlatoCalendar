import 'package:connectivity_plus/connectivity_plus.dart';
import '../Data/userData.dart';
import '../main.dart';
import 'onestop.dart';
import 'plato.dart';

/// 학생지원시스템, Plato 동기화를 진행함.
Future<bool> update({bool force = false, bool background = false}) async{
  if(UserData.id != ""){
    if(await (Connectivity().checkConnectivity()) == ConnectivityResult.none){
      DateTime now = DateTime.now();
      UserData.lastSyncInfo = "${now.day}일 ${now.hour}:${now.minute} - 네트워크 오류";
      return false;
    }
    if(DateTime.now().day != UserData.oneStopLastSyncDay)
      if(await Onestop.login() && await Onestop.getTestTimeTable() && await Onestop.logout()){}
    UserData.oneStopLastSyncDay = DateTime.now().day;

    // 수동 동기화 or 동기화 6시간 경과 or 백그라운드 동기화 3시간 경과
    if(force ||(DateTime.now().difference(UserData.lastSyncTime).inHours >= 6) || (background && DateTime.now().difference(UserData.lastSyncTime).inHours >= 3)){
      if(await Plato.login() && await Plato.getCalendar()){
        if(!background)
          pnuStream.sink.add(true);
        await UserData.writeDatabase.updateTime();
        return true;
      }
      return false;
    }
  }
    
  return false;
}
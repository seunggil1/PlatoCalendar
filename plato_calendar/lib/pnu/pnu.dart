import 'package:connectivity_plus/connectivity_plus.dart';
import '../Data/userData.dart';
import '../main.dart';
import 'onestop.dart';
import 'plato.dart';

/// 학생지원시스템, Plato 동기화를 진행함.
Future<bool> update({bool force = false, bool background = false}) async {
  DateTime now = DateTime.now();
  if (UserData.id != "") {
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      UserData.lastSyncInfo = "${now.day}일 ${now.hour}:${now.minute} - 네트워크 오류";
      return false;
    }
    if (now.day != UserData.oneStopLastSyncDay) if (await Onestop.login() &&
        await Onestop.getTestTimeTable() &&
        await Onestop.logout()) {}
    UserData.oneStopLastSyncDay = now.day;

    // foreground 상태에서 마지막 동기화로부터 6시간이 지나면 update
    bool foregroundUpdate = now.difference(UserData.lastSyncTime).inHours >= 6;
    // background 상태에서 마지막 동기화로부터 3시간이 지나면 update
    bool backgroundUpdate =
        background && now.difference(UserData.lastSyncTime).inHours >= 3;

    // 수동 동기화 or 동기화 6시간 경과 or 백그라운드 동기화 3시간 경과
    if (force || foregroundUpdate || backgroundUpdate) {
      if (await Plato.login() && await Plato.getCalendar()) {
        if (!background) // 백그라운드 아닐 경우 화면 갱신.
          pnuStream.sink.add(true);
        await UserData.writeDatabase.updateTime();
        return true;
      }
      return false;
    }
  }

  return false;
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:plato_calendar/utility.dart';

import 'Data/appinfo.dart';
import 'Data/database/database.dart';
import 'Data/database/foregroundDatabase.dart';
import 'Data/database/backgroundDatabase.dart';
import 'Data/ics.dart';
import 'Firebase/firebase.dart';
import 'Page/widget/adBanner.dart';
import 'Page/settings.dart';
import 'Page/sfCalendar.dart';
import 'Page/toDoList.dart';
import 'Data/userData.dart';
import 'pnu/pnu.dart';
// 프록시 사용할 떄 주석 해제 처리.
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }

/// Plato 동기화 완료됐을경우 화면 갱신 요청하는 Stream
StreamController pnuStream = StreamController<bool>.broadcast();

List<Widget> _widgets = [Calendar(), ToDoList(), Setting()];
void main() async{
  // HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  Future.wait([
    adBanner1.load(),
    adBanner2.load(),
    Future.delayed(Duration(seconds: 2))
  ]).then((value){
    pnuStream.sink.add(true);
  });
  await Database.init();
  await Appinfo.loadAppinfo();
  UserData.writeDatabase = ForegroundDatabase();
  UserData.readDatabase = await Database.recentlyUsedDatabase();
 
  await notificationInit();
  await UserData.readDatabase.lock();
  await UserData.writeDatabase.loadDatabase();
  await UserData.readDatabase.loadDatabase();

  UserData.readDatabase.userDataLoad();
  UserData.readDatabase.calendarDataLoad();
  UserData.readDatabase.googleDataLoad();

  // 자동으로 Save 안되는 부분은 수동으로 해주기.
  await Future.wait([
      UserData.writeDatabase.subjectCodeThisSemesterSave(),
      UserData.writeDatabase.defaultColorSave(),
      UserData.writeDatabase.uidSetSave(),
      UserData.writeDatabase.calendarDataFullSave()
  ]);
  await UserData.readDatabase.release();

  if(UserData.readDatabase is BackgroundDatabase)
    await UserData.readDatabase.closeDatabase();

  // for test
  // await icsParser("");
  await initializeDateFormatting('ko_KR', null);
  firebaseInit();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: UserData.themeMode,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  /// Loading 여부 표시, Loading중에는 터치 비활성화
  bool loading = false;
  StreamSubscription<bool> timerSubScription;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    timerSubScription = timer(10).listen((event) async { 
      await UserData.writeDatabase.updateTime();
    });
    
    UserData.googleCalendar.googleAsyncQueue = StreamController<CalendarData>();
    
    UserData.googleCalendar.googleAsyncQueue.stream.asyncMap((CalendarData data) async{
      print("Google Calendar Update");
      bool result;
      if(data.disable || data.finished) // (UserData.showFinished && data.finished)
        result = await UserData.googleCalendar.deleteCalendar(data.toEvent());
      else
        result = await UserData.googleCalendar.updateCalendar(data.toEvent());
      if(!result){
        if(UserData.googleCalendar.failCount >= 9)
          UserData.googleCalendar.googleAsyncQueue.close();
        else
          UserData.googleCalendar.googleAsyncQueue.add(data);
      }
      UserData.googleCalendar.asyncQueueSize--;
      await Future.delayed(Duration(seconds: UserData.googleCalendar.delayTime));
    }).listen((event) { });

    UserData.googleCalendar.updateCalendarFull();
    update();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    UserData.googleCalendar.closeStream();
    adBanner1.dispose();
    adBanner2.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //a.login().then((value) => a.getCalendar());
    return AbsorbPointer(
      absorbing: loading,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          //backgroundColor: Colors.white,
          selectedItemColor: Colors.blueAccent[100],
          unselectedItemColor: Colors.grey[400].withOpacity(1),
          currentIndex: UserData.tapIndex,
          onTap: (int i){
            setState(() { UserData.tapIndex = i; });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              label: "달력"),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books_outlined),
              label: "할일"),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "설정"),
          ]
        ),
        body: _widgets[UserData.tapIndex]
      ));

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        showToastMessageCenter("resumed");
        setState(() {
          loading = true;
        });
        UserData.readDatabase = BackgroundDatabase();
        DateTime beforeSync = await UserData.writeDatabase.getTime();
        DateTime nowSync = await UserData.readDatabase.getTime();
        
        if(nowSync.difference(beforeSync).inSeconds > 0){
          showToastMessageCenter("데이터를 불러오고 있습니다..");
          
          await UserData.readDatabase.lock();
          await UserData.readDatabase.loadDatabase();

          UserData.readDatabase.calendarDataLoad();
          UserData.readDatabase.userDataLoad();

          // 자동으로 Save 안되는 부분은 수동으로 해주기.
          await Future.wait([
              UserData.writeDatabase.subjectCodeThisSemesterSave(),
              UserData.writeDatabase.defaultColorSave(),
              UserData.writeDatabase.uidSetSave(),
              UserData.writeDatabase.calendarDataFullSave()
          ]);
          
          await UserData.readDatabase.closeDatabase();
          UserData.readDatabase.release();
          pnuStream.sink.add(true);
        }

        setState(() {
          loading = false;
        });
        closeToastMessage();
        timerSubScription.resume();
        break;
      case AppLifecycleState.inactive:
        showToastMessageCenter("paused");
        timerSubScription.pause();
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

}

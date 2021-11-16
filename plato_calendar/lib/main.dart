import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:plato_calendar/utility.dart';
import 'Data/database.dart';
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
StreamSubscription<bool> timerSubScription;
// Database.updateTime();
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
  await Database.loadDatabase();
  Database.userDataLoad();
  Database.calendarDataLoad();
  Database.googleDataLoad();
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
        primaryColor: Colors.white,
        // primarySwatch: Typography.white,
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    timerSubScription = timer(10).listen((event) async { 
      await Database.updateTime();
    });
    update().then((value) {
      Database.release();
    });
  }

  @override
  void dispose() {
    adBanner1.dispose();
    adBanner2.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //a.login().then((value) => a.getCalendar());
    return Scaffold(
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
          ],
        ),
        body: _widgets[UserData.tapIndex]
      );
  }
}

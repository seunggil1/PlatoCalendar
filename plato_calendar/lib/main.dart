import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'Data/database.dart';
import 'Data/ics.dart';
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
StreamController platoStream = StreamController<bool>.broadcast();
List<Widget> _widgets = [Calendar(), ToDoList(), Setting()];
void main() async{
  // HttpOverrides.global = new MyHttpOverrides();

  // for test
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  //await icsParser("");
  await Database.init();
  Database.userDataLoad();
  Database.calendarDataLoad();

  await initializeDateFormatting('ko_KR', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        // primarySwatch: Typography.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
    update().then((value) { // update 한 뒤에, 6시간마다 update 다시 진행.
      Stream.periodic(Duration(hours: 1, minutes: 1),(x)=>x).forEach((element) { 
        update();
      });
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
          backgroundColor: Colors.white,
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

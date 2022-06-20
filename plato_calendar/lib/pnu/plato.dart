import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../Data/database/database.dart';
import '../Data/userData.dart';
import '../Data/ics.dart';
import '../notify.dart';
import '../utility.dart';

class Plato {
  static String moodleSession = "";
  static String sesskey = "";

  static Future<bool> login() async {
    String body =
        'username=${UserData.id}&password=${Uri.encodeQueryComponent(UserData.pw)}'; //&loginbutton=%EB%A1%9C%EA%B7%B8%EC%9D%B8';
    Response response;

    try {
      response = await Dio().post("https://plato.pusan.ac.kr/login/index.php",
          options: Options(
              followRedirects: false,
              contentType: "application/x-www-form-urlencoded",
              headers: {
                "Host": "plato.pusan.ac.kr",
                "Connection": "close",
                "Content-Length": body.length.toString(),
                "Cache-Control": "max-age=0",
                "sec-ch-ua":
                    'Chromium;v="88", "Google Chrome";v="88", ";Not A Brand";v="99"',
                "sec-ch-ua-mobile": "?0",
                "Upgrade-Insecure-Requests": "1",
                "User-Agent":
                    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36",
                "Origin": "https://plato.pusan.ac.kr",
                "Content-Type": "application/x-www-form-urlencoded",
                "Accept":
                    "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
                "Referer": "https://plato.pusan.ac.kr/",
                "Accept-Encoding": "gzip, deflate",
                "Accept-Language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
              }),
          data: body);

      return false;
    } catch (e) {
      if (e.runtimeType == DioError && e.error == "Http status error [303]")
        response = e.response;
      else {
        print("plato Login Error: ${e.error}");
        DateTime now = DateTime.now();
        UserData.lastSyncInfo =
            "${now.day}일 ${now.hour}:${now.minute} - 로그인 오류";
        return false;
      }
    }
    if (response.headers.map["location"][0] ==
        "https://plato.pusan.ac.kr/login.php?errorcode=3") {
      print("ID,PW is incorrect");
      DateTime now = DateTime.now();
      UserData.lastSyncInfo =
          "${now.day}일 ${now.hour}:${now.minute} - ID/PW 오류";
    } else {
      moodleSession = response.headers.map["set-cookie"][1];
      moodleSession = moodleSession.substring(0, moodleSession.indexOf(';'));
      return true;
    }
    return false;
  }

  static Future<bool> getCalendar() async {
    try {
      http.Response response;
      response = await http.get(
          Uri.parse("https://plato.pusan.ac.kr/calendar/export.php?course=1"),
          headers: {
            "Host": "plato.pusan.ac.kr",
            "Connection": "close",
            "Cache-Control": "max-age=0",
            "Upgrade-Insecure-Requests": "1",
            "User-Agent":
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36 Edg/88.0.705.63",
            "Accept":
                "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
            "Accept-Encoding": "gzip, deflate",
            "Accept-Language": "ko,en;q=0.9,en-US;q=0.8",
            "Cookie": moodleSession
          });
      String requestBody1, requestBody2;
      requestBody1 = RegExp('"sesskey":".*?"').stringMatch(response.body);
      requestBody1 = '{' + requestBody1 + '}';
      sesskey = "sesskey=${jsonDecode(requestBody1)["sesskey"]}";

      requestBody1 = "$sesskey&_qf__core_calendar_export_form=1" +
          "&${Uri.encodeQueryComponent("events[exportevents]")}=all" +
          "&${Uri.encodeQueryComponent("period[timeperiod]")}=monthnow" +
          "&export=${Uri.encodeQueryComponent("내보내기")}";

      requestBody2 = "$sesskey&_qf__core_calendar_export_form=1" +
          "&${Uri.encodeQueryComponent("events[exportevents]")}=all" +
          "&${Uri.encodeQueryComponent("period[timeperiod]")}=recentupcoming" +
          "&export=${Uri.encodeQueryComponent("내보내기")}";

      await Future.wait([
        http.post(Uri.parse("https://plato.pusan.ac.kr/calendar/export.php"),
            headers: {
              "Host": "plato.pusan.ac.kr",
              "Connection": "close",
              "Content-Length": requestBody1.length.toString(),
              "Cache-Control": "max-age=0",
              "Upgrade-Insecure-Requests": "1",
              "User-Agent":
                  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36 Edg/88.0.705.63",
              "Origin": "https://plato.pusan.ac.kr",
              "Content-Type": "application/x-www-form-urlencoded",
              "Accept":
                  "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
              "Referer":
                  "https://plato.pusan.ac.kr/calendar/export.php?course=1",
              "Accept-Encoding": "gzip, deflate",
              "Accept-Language": "ko,en;q=0.9,en-US;q=0.8",
              "Cookie": moodleSession
            },
            body: requestBody1),
        http.post(Uri.parse("https://plato.pusan.ac.kr/calendar/export.php"),
            headers: {
              "Host": "plato.pusan.ac.kr",
              "Connection": "close",
              "Content-Length": requestBody2.length.toString(),
              "Cache-Control": "max-age=0",
              "Upgrade-Insecure-Requests": "1",
              "User-Agent":
                  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36 Edg/88.0.705.63",
              "Origin": "https://plato.pusan.ac.kr",
              "Content-Type": "application/x-www-form-urlencoded",
              "Accept":
                  "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
              "Referer":
                  "https://plato.pusan.ac.kr/calendar/export.php?course=1",
              "Accept-Encoding": "gzip, deflate",
              "Accept-Language": "ko,en;q=0.9,en-US;q=0.8",
              "Cookie": moodleSession
            },
            body: requestBody2)
      ]).then((value) async {
        Plato.logout();
        await icsParser(value[0].body);
        await icsParser(value[1].body);
      });

      UserData.lastSyncTime = DateTime.now();
      UserData.lastSyncInfo =
          "${UserData.lastSyncTime.day}일 ${UserData.lastSyncTime.hour}:${UserData.lastSyncTime.minute} - 동기화 성공";
      await Future.wait([
        UserData.writeDatabase.subjectCodeThisSemesterSave(),
        UserData.writeDatabase.defaultColorSave(),
        UserData.writeDatabase.uidSetSave()
      ]);
    } catch (e, trace) {
      Notify.notifyDebugInfo(e.toString(), sendLog: true, trace: trace);
      DateTime now = DateTime.now();
      UserData.lastSyncInfo =
          "${now.day}일 ${now.hour}:${now.minute} - 동기화 오류\n${e.toString()}";
      return false;
    }
    return true;
  }

  static Future<bool> logout() async {
    Response response;
    try {
      response = await Dio().get(
          "https://plato.pusan.ac.kr/login/logout.php?$sesskey",
          options: Options(
              followRedirects: false,
              contentType: "application/x-www-form-urlencoded",
              headers: {
                "Host": "plato.pusan.ac.kr",
                "Connection": "keep-alive",
                "Pragma": "no-cache",
                "Cache-Control": "no-cache",
                "sec-ch-ua":
                    'Chromium;v="88", "Google Chrome";v="88", ";Not A Brand";v="99"',
                "sec-ch-ua-mobile": "?0",
                "Upgrade-Insecure-Requests": "1",
                "User-Agent":
                    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36",
                "Accept":
                    "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
                "Referer":
                    "https://plato.pusan.ac.kr/calendar/export.php?course=1",
                "Accept-Encoding": "gzip, deflate, br",
                "Accept-Language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
                "Cookie": moodleSession
              }));
      return false;
    } catch (e) {
      if (e.runtimeType == DioError && e.error == "Http status error [303]")
        response = e.response;
      else {
        print("plato Logout Error: ${e.error}");
        return false;
      }
    }

    if (response.headers.map["location"][0] == "https://plato.pusan.ac.kr/") {
      moodleSession = response.headers.map["set-cookie"][0];
      moodleSession = moodleSession.substring(0, moodleSession.indexOf(';'));
      return true;
    }
    return false;
  }
}

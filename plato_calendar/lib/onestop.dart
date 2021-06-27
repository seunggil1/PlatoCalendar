import 'dart:convert';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:plato_calendar/Data/ics.dart';

import 'Data/database.dart';
import 'Data/userData.dart';

class Onestop {
  static String jsessionid;
  static String wmonid;

  static Future<bool> login() async {
    http.Response response;
    dom.Document document;

    List<dom.Element> list;
    String body = '';

    String studentNumber = UserData.id;
    String password = UserData.pw;
    studentNumber = studentNumber.trim();

    try {
      response = await http.post(
        'https://sso.pusan.ac.kr/LoginServlet?method=idpwProcessEx&ssid=49',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Host": "sso.pusan.ac.kr",
          "Referer": "https://e-onestop.pusan.ac.kr/index?home=home",
        },
        body: 'id=$studentNumber&pw=$password',
      );

      document = parser.parse(response.body);
      body = response.body;
      list = document.getElementsByTagName('input');

      // id pw 체크
      list.forEach((iter) {
        if (iter.attributes['name'] == "reTry")
          if (iter.attributes['value'] == "Y") {
            body = body.substring(body.indexOf('var msg'), body.length);
            body = body.substring(0, body.indexOf(';'));
            body = body.substring(body.indexOf('\=') + 3, body.lastIndexOf('\"'));
            throw Exception(body);
          }
      });

      body = '';
      for (int i = 0; i < list.length; i++) {
        body += list[i].attributes['name'] + '=' + list[i].attributes["value"];
        if (i < list.length - 1) body += '&';
      }
      response = await http.post(
        'https://e-onestop.pusan.ac.kr/sso/business',
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Host": "e-onestop.pusan.ac.kr",
            "Referer": "https://sso.pusan.ac.kr/LoginServlet?method=idpwProcessEx&ssid=49",
          },
          body: body);
      document = parser.parse(response.body);

      String cookiesOrigin = response.headers['set-cookie'];
      List<String> cookieList = cookiesOrigin.split('/,');
      for (int i = 0; i < 2; i++) {
        cookieList[i] = cookieList[i].substring(0, cookieList[i].indexOf(';'));
      }
      jsessionid = cookieList[1];
      wmonid = cookieList[0];
      //end at here

      list = document.getElementsByTagName('input');
      body = '';
      for (int i = 0; i < list.length; i++) {
        body += list[i].attributes['name'] + '=' + list[i].attributes["value"];
        if (i < list.length - 1)
          body += '&';
      }
      response = await http.post(
        'https://e-onestop.pusan.ac.kr/sso/checkauth',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Cookie": "${cookieList[0]}; ${cookieList[1]}",
          "Host": "e-onestop.pusan.ac.kr",
          "Referer": "https//e-onestop.pusan.ac.kr/sso/business",
        },
        body: body,
      );
      document = parser.parse(response.body);

      list = document.getElementsByTagName('input');
      body = '';
      for (int i = 0; i < list.length; i++) {
        body += list[i].attributes['name'] + '=' + list[i].attributes["value"];
        if (i < list.length - 1)
          body += '&';
      }
      response = await http.post(
        'https://sso.pusan.ac.kr/LoginServlet',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Cookie": "${cookieList[0]}; ${cookieList[1]}",
          "Host": "e-onestop.pusan.ac.kr",
          "Referer": "https://e-onestop.pusan.ac.kr/sso/checkauth",
        },
        body: body,
      );
      document = parser.parse(response.body);

      list = document.getElementsByTagName('input');
      body = '';
      for (int i = 0; i < list.length; i++) {
        body += list[i].attributes['name'] + '=' + list[i].attributes["value"];
        if (i < list.length - 1) body += '&';
      }
      response = await http.post(
        'https://e-onestop.pusan.ac.kr/sso/agentProc',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Cookie": "${cookieList[0]}; ${cookieList[1]}",
          "Host": "e-onestop.pusan.ac.kr",
          "Referer": "https://sso.pusan.ac.kr/LoginServlet",
        },
        body: 'method=auth',
      );
      document = parser.parse(response.body);

      list = document.getElementById('ssoLoginForm').getElementsByTagName('input');
      body = '';
      for (int i = 0; i < 1; i++) {
        body += list[i].attributes['name'] + '=' + list[i].attributes["value"];
        if (i < list.length - 1)
          body += '&';
      }
      body += list[1].attributes['name'] + '=';

      response = await http.post(
        'https://e-onestop.pusan.ac.kr/j_spring_security_check',
        headers: {
          "Host": "e-onestop.pusan.ac.kr",
          "Connection": "keep-alive",
          "Content-Type": "application/x-www-form-urlencoded",
          "Cookie": "${cookieList[0]}; ${cookieList[1]}",
          "Origin": "https://e-onestop.pusan.ac.kr",
          "Referer": "https://e-onestop.pusan.ac.kr/sso/agentProc",
        },
        body: body,
      );
      document = parser.parse(response.body);
      body = response.headers['set-cookie'];
      body = body.substring(0, body.indexOf(';'));

      jsessionid = body;
      print("Login finished $jsessionid");

    } catch (e) {
      return false;
    }

    return true;
  }

  static Future<bool> getTestTimeTable() async {
    try{
      http.Response response;
      response = await http.get('https://e-onestop.pusan.ac.kr/menu/class/C06/C06002?menuId=2000030702&rMenu=03',
      headers: {
        'Host' : 'e-onestop.pusan.ac.kr',
        'Connection' : 'keep-alive',
        'Cache-Control' : 'no-cache',
        'Referer' : 'https://e-onestop.pusan.ac.kr/index?home=home',
        'Cookie' : '$wmonid; $jsessionid'
      });

      // 학번 정보
      int index = response.body.indexOf('agreeUserID');
      String userInfo = response.body.substring(index, response.body.indexOf(';',index));
      userInfo = userInfo.substring(userInfo.indexOf('\'') +1,userInfo.length -1);

      // 학부 대학원 구분
      index = response.body.indexOf('year, term,');
      String studentType = response.body.substring(index + 12, response.body.indexOf('testgbn',index));
      index = studentType.indexOf(',');
      studentType = studentType.substring(index+3, studentType.indexOf(',', index+3) -1);

      DateTime now = DateTime.now();
      String semester = now.month <= 7 ? "10" : "20";
      String test;
      if(semester == "10"){
        test = now.month <= 5 ? "10" : "20";
      }else{
        test = now.month <= 11 ? "10" : "20";
      }
      Map<String, dynamic> body = {
        "pName" : ["년도","학기","학번","학번대학원구분","시험구분"],
        "pValue" : [now.year, semester, userInfo, studentType, test]
      };
      response = await http.post('https://e-onestop.pusan.ac.kr/middleware/study/testTimeTable/testTimeTableCheck',
        headers: {
          'Host' : 'e-onestop.pusan.ac.kr',
          'Connection' : 'keep-alive',
          'Cache-Control' : 'no-cache',
          'Content-Type' : 'application/json',
          'Origin': 'https://e-onestop.pusan.ac.kr',
          'Referer' : 'https://e-onestop.pusan.ac.kr/menu/class/C06/C06002?menuId=2000030702&rMenu=03',
          'Cookie' : '$wmonid; $jsessionid'
        },
        body: jsonEncode(body));
      
      await testTimeParser(jsonDecode(response.body)["dataset1"],[now.year.toString(), semester, test == "10" ? "중간고사" : "기말고사"]);
      
    }catch(e){
      return false;
    }
    UserData.oneStopLastSyncDay = DateTime.now().day;
    Database.subjectCodeThisSemesterSave();
    Database.defaultColorSave();
    Database.uidSetSave();
    return true;
  }
  static Future<bool> logout() async {
    try{
      http.Response response;
      response = await http.get('https://e-onestop.pusan.ac.kr/sso/logout', 
          headers: {
            "Cookie": "$wmonid; $jsessionid",
            "Host": "e-onestop.pusan.ac.kr",
            "Referer": "https://e-onestop.pusan.ac.kr/index?home=home",
          });

      response = await http.post('http://sso.pusan.ac.kr/isignplus/logout.jsp',
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Host": "sso.pusan.ac.kr",
          },
          body: "ssid=49&domain=.pusan.ac.kr");
      String ntassessionid = response.headers["set-cookie"];
      ntassessionid = ntassessionid.substring(0, ntassessionid.indexOf(';'));

      response = await http.post('http://sso.pusan.ac.kr/LoginServlet',
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Cookie": "$ntassessionid",
            "Host": "sso.pusan.ac.kr",
            "Origin": "http://sso.pusan.ac.kr",
            "Referer": "http://sso.pusan.ac.kr/isignplus/logout.jsp",
          },
          body: "ssid=49&secureSessionId=&method=logout");

      ntassessionid = response.headers["set-cookie"];
      ntassessionid = ntassessionid.substring(0, ntassessionid.indexOf(';'));

      response = await http.post('https://e-onestop.pusan.ac.kr/sso/business',
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Cookie": "$wmonid; $jsessionid",
            "Host": "e-onestop.pusan.ac.kr",
            "Origin": "http://sso.pusan.ac.kr",
            "Referer": "http://sso.pusan.ac.kr/LoginServlet",
          },
          body:
              "secureToken=&secureSessionId=&isToken=N&reTry=Y&method=checkToken&login_type=");
      String result = response.headers["set-cookie"];
      jsessionid = result.substring(0, result.indexOf(';'));
    }catch(e){
      return false;
    }

    return true;

  }

}
import 'dart:convert';

import 'package:http/http.dart';

// 개발용 crawling code

// 대학원 과목 list
Future<void> getGraduateSubject() async {
  Map<String, String> result = {};
  for(int i = 1; i <= 15; i ++){
    Response res = await post(Uri.parse('https://e-onestop.pusan.ac.kr/middleware/study/graduateLectureManual/graduateLectureManualMajorListCheck'),
      headers: {
        "Origin": "https://e-onestop.pusan.ac.kr",
        "Content-Type": "application/json",
        "Host": "e-onestop.pusan.ac.kr",
        "Referer": "https://e-onestop.pusan.ac.kr/menu/class/C03/C03002?menuId=2000030302&rMenu=03"
      },
      body: '{"pName":["YEAR","TERM","GRAD_GBN"],"pValue":["2021","10","${i < 10 ? "0"+i.toString() : i.toString()}"]}'
    );
    var departMentList = jsonDecode(res.body);
    for(var depart in departMentList["dataset1"]){
      res = await post(Uri.parse('https://e-onestop.pusan.ac.kr/middleware/study/graduateLectureManual/graduateLectureManualCheck'),
        headers: {
          "Origin": "https://e-onestop.pusan.ac.kr",
          "Content-Type": "application/json",
          "Host": "e-onestop.pusan.ac.kr",
          "Referer": "https://e-onestop.pusan.ac.kr/menu/class/C03/C03002?menuId=2000030302&rMenu=03"
        },
        body: '{"pName":["YEAR","TERM","DEPTCD","CHK"],"pValue":["2021","10","${depart["학과코드"]}","Y"]}'
      );
      var subjectList = jsonDecode(res.body);
      for(var subject in subjectList["dataset1"]){
        result[subject["교과목번호"]] = subject["교과목명"];
      }
    }
  }
  result.forEach((key, value) {
    print("'$key':'$value',");
  });

}

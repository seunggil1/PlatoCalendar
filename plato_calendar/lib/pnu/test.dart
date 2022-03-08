import 'dart:convert';

import 'package:http/http.dart';
import 'package:plato_calendar/Data/subjectCode.dart';

// 개발용 crawling code

final int _YEAR = 2022;
final int _SEMESTER = 10;
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
      body: '{"pName":["YEAR","TERM","GRAD_GBN"],"pValue":["$_YEAR","$_SEMESTER","${i < 10 ? "0"+i.toString() : i.toString()}"]}'
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
        body: '{"pName":["YEAR","TERM","DEPTCD","CHK"],"pValue":["$_YEAR","$_SEMESTER","${depart["학과코드"]}","Y"]}'
      );
      var subjectList = jsonDecode(res.body);
      for(var subject in subjectList["dataset1"]){
        result[subject["교과목번호"]] = subject["교과목명"];
      }
    }
  }
  // 현재 App에 없는 과목 데이터만 표시.
  result.forEach((key, value) {
    if(!subjectCode.containsKey(key)){
      print("'$key':'$value',");
    }
  });


  // // 과목명이 바뀐 데이터만 표시.
  // result.forEach((key, value) {
  //   if(subjectCode.containsKey(key) && subjectCode[key] != value){
  //     print("'$key':'$value',");
  //   }
  // });
}

// 학부 과목 list
Future<void> getDepartmentSubject() async {
  Map<String, String> result = {};

  // 교양선택
  Response res = await post(Uri.parse('https://e-onestop.pusan.ac.kr/middleware/curriculum/lliveralArts/lliveralArtsAreaSearch'),
      headers: {
        "Content-Type": "application/json",
        "Origin": "https://e-onestop.pusan.ac.kr",
        "Host": "e-onestop.pusan.ac.kr",
        "Referer": "https://e-onestop.pusan.ac.kr/menu/class/C03/C03001?menuId=2000030301&rMenu=03"
      },
      body: '{"pName":[],"pValue":[]}'
    );
  // 교양 영역 리스트
  var electiveSubjectAreaList = jsonDecode(res.body);

  // 각 영역별 교양과목
  for(var area in electiveSubjectAreaList["dataset1"]){
    if(area["년도"] == "$_YEAR"){
      res = await post(Uri.parse('https://e-onestop.pusan.ac.kr/middleware/curriculum/college/CollegeAssignInfoSearch'),
        headers: {
          "Content-Type": "application/json",
          "Origin": "https://e-onestop.pusan.ac.kr",
          "Host": "e-onestop.pusan.ac.kr",
          "Referer": "https://e-onestop.pusan.ac.kr/menu/class/C03/C03001?menuId=2000030301&rMenu=03"
        },
        body: '{"pName":["YEAR","TERM","DEPTCD","CULTCD","GUBUN","CORE_ABILITY"],"pValue":["$_YEAR","$_SEMESTER","","${area["교양영역코드"]}","3","00"]}'
      );
      var subjectList = jsonDecode(res.body);
      for(var subject in subjectList["dataset1"]){
        result[subject["교과목번호"]] = subject["교과목명"];
      }
    }
  }

  // 일반선택
  res = await post(Uri.parse('https://e-onestop.pusan.ac.kr/middleware/curriculum/college/CollegeAssignInfoSearch'),
    headers: {
      "Content-Type": "application/json",
      "Origin": "https://e-onestop.pusan.ac.kr",
      "Host": "e-onestop.pusan.ac.kr",
      "Referer": "https://e-onestop.pusan.ac.kr/menu/class/C03/C03001?menuId=2000030301&rMenu=03"
    },
    body: '{"pName":["YEAR","TERM","DEPTCD","CULTCD","GUBUN","CORE_ABILITY"],"pValue":["$_YEAR","$_SEMESTER","Z0076","","5","00"]}'
  );
  var subjectList = jsonDecode(res.body);
  for(var subject in subjectList["dataset1"]){
    result[subject["교과목번호"]] = subject["교과목명"];
  }

  // 교양필수

  // 학과 구분
  res = await post(Uri.parse('https://e-onestop.pusan.ac.kr/middleware/curriculum/college/curriculumCollegeDetailListSearch'),
      headers: {
        "Content-Type": "application/json",
        "Origin": "https://e-onestop.pusan.ac.kr",
        "Host": "e-onestop.pusan.ac.kr",
        "Referer": "https://e-onestop.pusan.ac.kr/menu/class/C03/C03001?menuId=2000030301&rMenu=03"
      },
      body: '{"pName":["YEAR","TERM","SUBJECT"],"pValue":["$_YEAR","$_SEMESTER","4"]}'
    );
  
  var collegeList = jsonDecode(res.body);
  for(var area in collegeList["dataset1"]){
      res = await post(Uri.parse('https://e-onestop.pusan.ac.kr/middleware/curriculum/college/CollegeAssignInfoSearch'),
        headers: {
          "Content-Type": "application/json",
          "Origin": "https://e-onestop.pusan.ac.kr",
          "Host": "e-onestop.pusan.ac.kr",
          "Referer": "https://e-onestop.pusan.ac.kr/menu/class/C03/C03001?menuId=2000030301&rMenu=03"
        },
        body: '{"pName":["YEAR","TERM","DEPTCD","CULTCD","GUBUN","CORE_ABILITY"],"pValue":["$_YEAR","$_SEMESTER","${area["학과코드"]}","","4","00"]}'
      );
      var subjectList = jsonDecode(res.body);
      for(var subject in subjectList["dataset1"]){
        result[subject["교과목번호"]] = subject["교과목명"];
      }
  }

  // 전공 기초
  // 학과 정보 얻기
  res = await post(Uri.parse('https://e-onestop.pusan.ac.kr/middleware/curriculum/college/curriculumCollegeDetailListSearch'),
      headers: {
        "Content-Type": "application/json",
        "Origin": "https://e-onestop.pusan.ac.kr",
        "Host": "e-onestop.pusan.ac.kr",
        "Referer": "https://e-onestop.pusan.ac.kr/menu/class/C03/C03001?menuId=2000030301&rMenu=03"
      },
      body: '{"pName":["YEAR","TERM","SUBJECT"],"pValue":["$_YEAR","$_SEMESTER","2"]}'
    );
  collegeList = jsonDecode(res.body);

  // 과목 정보 얻기
  for(var area in collegeList["dataset1"]){
      res = await post(Uri.parse('https://e-onestop.pusan.ac.kr/middleware/curriculum/college/CollegeAssignInfoSearch'),
        headers: {
          "Content-Type": "application/json",
          "Origin": "https://e-onestop.pusan.ac.kr",
          "Host": "e-onestop.pusan.ac.kr",
          "Referer": "https://e-onestop.pusan.ac.kr/menu/class/C03/C03001?menuId=2000030301&rMenu=03"
        },
        body: '{"pName":["YEAR","TERM","DEPTCD","CULTCD","GUBUN","CORE_ABILITY"],"pValue":["$_YEAR","$_SEMESTER","${area["학과코드"]}","","2","00"]}'
      );
      var subjectList = jsonDecode(res.body);
      for(var subject in subjectList["dataset1"]){
        result[subject["교과목번호"]] = subject["교과목명"];
      }
  }

  // 전공 필수
  res = await post(Uri.parse('https://e-onestop.pusan.ac.kr/middleware/curriculum/college/curriculumCollegeDetailListSearch'),
      headers: {
        "Content-Type": "application/json",
        "Origin": "https://e-onestop.pusan.ac.kr",
        "Host": "e-onestop.pusan.ac.kr",
        "Referer": "https://e-onestop.pusan.ac.kr/menu/class/C03/C03001?menuId=2000030301&rMenu=03"
      },
      body: '{"pName":["YEAR","TERM","SUBJECT"],"pValue":["$_YEAR","$_SEMESTER","1"]}'
    );

  collegeList = jsonDecode(res.body);
  for(var area in collegeList["dataset1"]){
      res = await post(Uri.parse('https://e-onestop.pusan.ac.kr/middleware/curriculum/college/CollegeAssignInfoSearch'),
        headers: {
          "Content-Type": "application/json",
          "Origin": "https://e-onestop.pusan.ac.kr",
          "Host": "e-onestop.pusan.ac.kr",
          "Referer": "https://e-onestop.pusan.ac.kr/menu/class/C03/C03001?menuId=2000030301&rMenu=03"
        },
        body: '{"pName":["YEAR","TERM","DEPTCD","CULTCD","GUBUN","CORE_ABILITY"],"pValue":["$_YEAR","$_SEMESTER","${area["학과코드"]}","","1","00"]}'
      );
      var subjectList = jsonDecode(res.body);
      for(var subject in subjectList["dataset1"]){
        result[subject["교과목번호"]] = subject["교과목명"];
      }
  }

  // 현재 App에 없는 과목 데이터만 표시.
  result.forEach((key, value) {
    if(!subjectCode.containsKey(key)){
      print("'$key':'$value',");
    }
  });

  // // 과목명이 바뀐 데이터만 표시.
  // result.forEach((key, value) {
  //   if(subjectCode.containsKey(key) && subjectCode[key] != value){
  //     print("'$key':'$value',");
  //   }
  // });
}

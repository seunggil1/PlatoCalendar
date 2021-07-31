import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis/calendar/v3.dart';
import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import './else.dart';
import './subjectCode.dart';
import './userData.dart';
import 'package:hive/hive.dart';
import 'package:open_file/open_file.dart';
import 'database.dart';

part 'ics.g.dart';
// UID	      일정의 고유한 ID 값. 단일 캘린더 ID에서는 iCalendar의 UID가 고유해야 한다.
//            UID는 일반적으로 iCalendar 데이터를 최초 생성할 때 사용자 ID, 타임스탬프, 도메인 등의 정보를 조합해서 만든다.
//            이때 특수 기호 % 문자는 이스케이프 문제로 지원되지 않으니 주의한다.
// DTSTART	  일정이 시작된 날짜 및 시간.
//            별도의 표준시간대를 사용하지 않는다면 'T' 이하의 시간 값만 수정해서 사용할 수 있다.
// DTEND	    일정이 종료된 날짜 및 시간.
//            별도의 표준시간대를 사용하지 않는다면 'T' 이하의 시간 값만 수정해서 사용할 수 있다.
// SUMMARY	  일정 제목
// DESCRIPTION	일정의 상세 내용
// LOCATION	  장소 정보
// RRULE	    반복 정보
// ORGANIZER	캘린더 시스템 이메일.
//            기본 캘린더에 약속 생성 시, 캘린더 API 서버에 의해서 기본 캘린더 Owner 이메일로 설정된다.
//            공유 캘린더에 약속 생성 시, 캘린더 API 서버에 의해서 캘린더 시스템 이메일로 설정된다.
//            약속 수정 시에는 조회된 ORGANIZER를 그대로 사용해야 한다.
//            약속이 아니면 ORGANIZER를 빼고 iCalendar 데이터를 생성한다.
// ATTENDEE	  약속인 경우 참석자 정보.
//            약속이 아니면 ATTENDEE를 빼고 iCalendar 데이터를 생성한다.
// CREATED	  일정이 생성된 날짜 및 시간
// LAST-MODIFIED	일정이 최종 수정된 날짜 및 시간
// DTSTAMP	  일정을 iCalendar 데이터로 변환한 날짜 및 시간(현재는 중요하지 않게 취급).

final Set<String> _calendarReserved= 
        {"BEGIN","METHOD","PRODID","VERSION","UID","SUMMARY","DESCRIPTION"
        ,"CLASS","LAST-MODIFIED","DTSTAMP","DTSTART","DTEND","CATEGORIES","END"}; 

Future<void> icsParser(String bytes) async{
  // For Test
  // String bytes = await rootBundle.loadString('icalexport.ics');
  List<String> linebytes = bytes.split('\r\n');
  // 일정 내용에 :가 있을 경우 오류가 발생하는 경우가 있어서 : -> ####로 교체하고 파싱진행.
  for(int i = 0; i<linebytes.length; i++){
    int index = linebytes[i].indexOf(':');
    if(index != -1){
      String first = linebytes[i].substring(0,index);
      if(_calendarReserved.contains(first))
        linebytes[i] = first + ':' + linebytes[i].substring(index+1).replaceAll(':', "####");
      else
        linebytes[i] = linebytes[i].replaceAll(':', "####");
    }
  }
  bytes = linebytes.join('\r\n');
  ICalendar iCalendar = ICalendar.fromString(bytes);

  for(var iter in iCalendar.data){
    CalendarData data = CalendarData.byMap(iter);
    if(!UserData.data.contains(data)){
      Database.uidSet.add(data.uid);
      Database.calendarDataSave(data);
      UserData.data.add(data);
    }
  }
  // For test
  // Database.uidSetSave();
  // Database.subjectCodeThisSemesterSave();
}

Future<bool> icsExport() async {
  try{
    final dir = (await getApplicationDocumentsDirectory()).path;
    File icsFile = File("$dir/data.ics");
    String data = "";
    data += ('BEGIN:VCALENDAR\n');
    data +=('METHOD:PUBLISH\n');
    data +=('PRODID:-//Moodle Pty Ltd//NONSGML Moodle Version 2018051709//EN\n');
    data +=('VERSION:2.0\n');
    for(var iter in UserData.data)
      if(DateTime.now().difference(iter.end).inDays < 35 && iter.finished == false){
        data += ('BEGIN:VEVENT\n');
        data += ('UID:${iter.uid}\n');
        data += ('SUMMARY:${iter.summary}\n');
        String description = iter.description.replaceAll('\n', '\\n');
        data += ('DESCRIPTION:$description\n');
        data += ('\n');
        data += ('CLASS:PUBLIC\n');
        data += ('LAST-MODIFIED:20201108T053930Z\n');
        data += ('DTSTAMP:${toISO8601(iter.end)}\n');
        DateTime start = iter.start.day == iter.end.day ? iter.start : iter.end;
        data += ('DTSTART:${toISO8601(start)}\n');
        data += ('DTEND:${toISO8601(iter.end)}\n');
        data += ('CATEGORIES:${iter.classCode}\n');
        data += ('END:VEVENT\n');
      }  
    data +=('END:VCALENDAR\n');

    icsFile.writeAsString(data);
    OpenResult result = await OpenFile.open("$dir/data.ics");
    if(result.type != ResultType.done)
      throw Error();

    return true;
  } catch(e){
    return false;
  }
}

Future<void> testTimeParser(dynamic dataList,List<String> requestInfo) async {
  for(var iter in dataList){
    CalendarData data = CalendarData.byTestTime(iter, requestInfo);
    if(!UserData.data.contains(data)){
      Database.uidSet.add(data.uid);
      Database.calendarDataSave(data);
      UserData.data.add(data);
    }
  }
}

class CalendarData{

  String uid;
  String summary;
  String description;

  DateTime start, end;

  bool isPeriod = true;

  String year;
  String semester;
  String classCode;
  String className;

  bool disable = false;
  bool finished = false;

  int color;

  CalendarData(this.uid, this.summary,this.description, this.start, this.end,
              this.isPeriod, this.year, this.semester, this.classCode, this.className,
              this.disable, this.finished, this.color);

  CalendarData.byMap(Map<String,dynamic> data){
    uid = data["uid"];
    summary = data["summary"];
    description = data["description"];
    description = description.replaceAll("####",":");
    description = description.replaceAll("\\n", "\n");
    
    start = data["dtstart"];
    end = data["dtend"];

    start = start.toLocal();
    end = end.toLocal();
    
    // 시간에서 초 부분 0으로 자르기, 59초인 경우 sfcalendar.scheduleview에서 토요일 일정 제대로 표시 못하는 오류가 있음.
    start = start.subtract(Duration(seconds: start.second));
    end = end.subtract(Duration(seconds: end.second));
    isPeriod = !(start == end);

    List classInfo;
    if(data.containsKey("categories")){
      classInfo = data["categories"][0].split('_');
    }else{
      classInfo = ["${UserData.year}", "${UserData.semester}", "과목 분류 없음", "000"];
    }

    if(classInfo.length > 2){
      year = classInfo[0];
      semester = classInfo[1];
      classCode = classInfo[2];
      className = subjectCode[classCode] ?? "";
      UserData.subjectCodeThisSemester.add(classCode);
      if(!UserData.defaultColor.containsKey(classCode) && UserData.defaultColor.length < 11)
        UserData.defaultColor[classCode] = UserData.defaultColor.length;
    }else{
      year = "No data";
      semester = "No data";
      classCode = classInfo[0];
      className = "";
    }
    
    if(end.hour == 0 && end.minute == 0){
      if(start == end)
        start = start.subtract(Duration(minutes: 1));
      end = end.subtract(Duration(minutes: 1));
    }

    color = UserData.defaultColor[classCode] ?? 18; // colorCollection[9] = Colors.lightGreen

  }

  CalendarData.byTestTime(Map<String,dynamic> data, List<String> requestInfo){
    // requestInfo = [2021, 10, 중간/기말고사]
    data = data.map((key, value) {
      value = value ?? "";
      value = value.toString().trim();
      return MapEntry(key, value);
    });
      
    uid = data["교과목번호"]+ data["분반"]+ data["시험일"];
    summary = data["교과목명"] + " ${requestInfo[2]}";
    description =  "${data["시험일"]} ${data["교과목명"]} ${data["분반"]}분반 ${requestInfo[2]}\n";
    description += "\n";
    description += "${data["건물명"]}(${data["건물코드"]}) : ${data["호실"]}\n";
    if(data["건물명2"] != "")
      description += "${data["건물명2"]}(${data["건물코드2"]}) : ${data["호실2"]}\n";
    if(data["건물명3"] != "")
      description += "${data["건물명3"]}(${data["건물코드3"]}) : ${data["호실3"]}\n";
    description += "(정확한 정보는 각 과목 공지사항를 확인해주세요.)";    

    List<int> day = List<int>.from(data["시험일"].split('.').map(int.parse));
    List<int> time = List<int>.from((data["시험시작시간"].split(':') + data["시험종료시간"].split(':')).map(int.parse));
    start = DateTime(day[0], day[1],day[2], time[0], time[1]);
    end = DateTime(day[0], day[1],day[2], time[2], time[3]);

    classCode = data["교과목번호"];
    className = subjectCode[classCode] ?? data["교과목명"];
    year = requestInfo[0];
    semester = requestInfo[1];

    UserData.subjectCodeThisSemester.add(classCode);
    if(!UserData.defaultColor.containsKey(classCode) && UserData.defaultColor.length < 11)
      UserData.defaultColor[classCode] = UserData.defaultColor.length;
    color = 11;
  }

  Appointment toAppointment(){
    return Appointment(
      startTime: start.day == end.day ? start : end,
      endTime: end,
      subject: summary,
      notes: description,
      color: colorCollection[color],
      resourceIds: <int>[hashCode]
    );
  }
  Event toEvent(){
    Event t = Event();
    t.iCalUID = this.uid;
    t.summary = this.summary;
    t.description = this.description;
    t.reminders = EventReminders(overrides : [EventReminder(method: "popup", minutes: 60)], useDefault: false);
    t.end = EventDateTime(dateTime: this.end, timeZone: "Asia/Seoul");

    if(this.end.day != this.start.day)
      t.start = EventDateTime(dateTime: this.end, timeZone: "Asia/Seoul");
    else
      t.start = EventDateTime(dateTime: this.start, timeZone: "Asia/Seoul");

    t.colorId = "${(this.color > 10 ? 10 : this.color)+ 1}";

    return t;
  }


  @override
  int get hashCode => uid.hashCode;

  @override
  bool operator ==(dynamic other) {
    if(!(other is CalendarData))
      return false;
    return this.uid == other.uid;
  }
}


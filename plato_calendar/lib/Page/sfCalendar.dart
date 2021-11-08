import 'dart:async';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../Data/userData.dart';
import 'widget/appointmentEditor.dart';
import '../utility.dart';

class Calendar extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _Calendar();
}

class _Calendar extends State<Calendar>{
  CalendarView viewType = CalendarView.month;
  CalendarController _calendarController = CalendarController();
  StreamSubscription<bool> listener;
  @override
  void initState() {
    super.initState();
    _calendarController.view = CalendarView.month;
    _calendarController.selectedDate = DateTime.now();
    listener = pnuStream.stream.listen((event) {
      if(event)
        setState(() {  });
    });
  }

  @override
  void dispose() {
    super.dispose();
    listener.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
          child: FutureBuilder(
            future: _getCalendarDataSource(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              return SafeArea(
                child: SfCalendar(
                  controller: _calendarController,
                  headerHeight: 30,
                  headerStyle: CalendarHeaderStyle(backgroundColor: Colors.blueAccent[100], textStyle: TextStyle(color: Colors.white, fontSize: 20)),
                  viewHeaderStyle : ViewHeaderStyle( dayTextStyle:TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  todayHighlightColor: Colors.blueAccent[100],
                  firstDayOfWeek: UserData.firstDayOfWeek, // 한주의 시작 - 1: 월 .., 7:일
                  monthViewSettings: MonthViewSettings(
                    appointmentDisplayCount: 4,
                    appointmentDisplayMode: UserData.calendarType == CalendarType.split ? MonthAppointmentDisplayMode.appointment : MonthAppointmentDisplayMode.indicator,
                    showAgenda: UserData.calendarType == CalendarType.split ? false : true,
                    monthCellStyle: MonthCellStyle()),
                  scheduleViewSettings: ScheduleViewSettings(
                    monthHeaderSettings: MonthHeaderSettings(
                      height: 100,
                      monthFormat: 'yyyy년 M월'
                    )
                  ),
                  dataSource: snapshot.hasData ? snapshot.data : DataSource([]),
                  onTap: (data){
                    if(UserData.calendarType == CalendarType.split){
                      if(_calendarController.view == CalendarView.month && data.targetElement == CalendarElement.calendarCell)
                        setState(() {
                          _calendarController.view = CalendarView.schedule;
                        });
                      else if(_calendarController.view == CalendarView.schedule && data.targetElement == CalendarElement.appointment){
                        showDialog(context: context,
                          builder: (BuildContext context){
                            return PopUpAppointmentEditor.appointment(data.appointments[0]);
                          }).then((value) => setState((){}));
                      }
                    }
                    else if(UserData.calendarType == CalendarType.integrated){
                      if(data.targetElement == CalendarElement.appointment){
                        showDialog(context: context,
                          builder: (BuildContext context){
                            return PopUpAppointmentEditor.appointment(data.appointments[0]);
                          }).then((value) => setState((){}));
                      }
                    }
                  },
                  onLongPress: (data){
                    if(data.targetElement == CalendarElement.appointment){
                      showDialog(context: context,
                        builder: (BuildContext context){
                          return SimplePopUpAppointmentEditor(data.appointments[0]);
                        }).then((value) => setState((){
                          if(value == true){ // 일정 완료
                            showMessage(context, "완료된 일정으로 변경했습니다.");
                          }else if(value == false){ // 일정 삭제
                            showMessage(context, "일정을 삭제 했습니다.");
                          }
                        }));
                    }
                  },
                )
              );
            }
          ),
        ),
      onWillPop: () async {
        if(_calendarController.view == CalendarView.schedule){
          setState(() {
            _calendarController.view = CalendarView.month;
          });
          return false;
        }
        else
          return true;
      });
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment>  source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) => appointments[index].from;

  @override
  DateTime getEndTime(int index) => appointments[index].to;
  
  @override
  String getSubject(int index) => appointments[index].eventName;
  
  @override
  Color getColor(int index) => appointments[index].background;

  @override
  bool isAllDay(int index) => appointments[index].isAllDay;
}

Future<DataSource> _getCalendarDataSource() async {

  List<Appointment> appointments = <Appointment>[];
  for(var iter in UserData.data)
    if(!iter.disable &&(!iter.finished || UserData.showFinished))
      appointments.add(iter.toAppointment());
  
  return DataSource(appointments);
}



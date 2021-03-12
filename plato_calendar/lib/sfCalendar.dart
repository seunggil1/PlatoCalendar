import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

import 'Data/userData.dart' as userData;
import 'appointmentEditor.dart';
import 'ics.dart';
import 'plato.dart';

class Calendar extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _Calendar();
}

class _Calendar extends State<Calendar>{
  CalendarView viewType = CalendarView.month;
  CalendarController _calendarController = CalendarController();
 
  @override
  void initState() {
    super.initState();
    _calendarController.view = CalendarView.month;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
          child: FutureBuilder(
            future: _getCalendarDataSource(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              return SfCalendar(
                controller: _calendarController,
                headerHeight: 30,
                headerStyle: CalendarHeaderStyle(backgroundColor: Colors.blue, textStyle: TextStyle(color: Colors.white, fontSize: 20)),
                viewHeaderStyle : ViewHeaderStyle(backgroundColor: Colors.white, dayTextStyle:TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                firstDayOfWeek: userData.firstDayOfWeek, // 한주의 시작 - 1: 월 .., 7:일
                monthViewSettings: MonthViewSettings(
                  appointmentDisplayCount: 4,
                  appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                  monthCellStyle: MonthCellStyle()),
                scheduleViewSettings: ScheduleViewSettings(
                  monthHeaderSettings: MonthHeaderSettings(
                    height: 100,
                    monthFormat: 'yyyy년 M월'
                  )
                ),
                dataSource: snapshot.hasData ? snapshot.data : DataSource([]),
                onTap: (data){
                  if(_calendarController.view == CalendarView.month)
                    setState(() {
                      _calendarController.view = CalendarView.schedule;
                    });
                  else if(_calendarController.view == CalendarView.schedule && data.targetElement == CalendarElement.appointment){
                    showDialog(context: context,
                      builder: (BuildContext context){
                        return PopUpAppointmentEditor.appointment(data.appointments[0]);
                      }).then((value) => setState((){}));
                  }
                },
              );
            }
          ),
        ),
      onWillPop: () async {
        if(_calendarController.view == CalendarView.schedule)
          setState(() {
            _calendarController.view = CalendarView.month;
            return false;
          });
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
  for(var iter in userData.data)
    if(!iter.disable &&(!iter.finished || userData.showFinished))
      appointments.add(iter.toAppointment());
  
  return DataSource(appointments);
}
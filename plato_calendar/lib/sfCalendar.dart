import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

import 'Data/userData.dart';
import 'ics.dart';
import 'plato.dart';

class Calendar extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _Calendar();
}

class _Calendar extends State<Calendar>{
  @override
  Widget build(BuildContext context) {
    //a.login().then((value) => a.getCalendar());
    return Container(
          child: FutureBuilder(
            future: _getCalendarDataSource(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              return SfCalendar(
                headerHeight: 30,
                view: CalendarView.month,
                firstDayOfWeek: 0, // 한주의 시작 - 0: 일, 1: 월 ..
                monthViewSettings: MonthViewSettings(
                  appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                  monthCellStyle: MonthCellStyle()),
                dataSource: snapshot.hasData ? snapshot.data : DataSource(List<Appointment>()),
                onTap: test,
                onLongPress: test2,
                onViewChanged: test3,
              );
            }
          ),
        );
  }

}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
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
  // Plato login = Plato();
  // await login.login();
  // await login.getCalendar();

  // for test
  await icsParser("");
  List<Appointment> appointments = <Appointment>[];
  for(var iter in data)
    appointments.add(iter.toAppointment());
  
  return DataSource(appointments);
}

void test(CalendarTapDetails data){
  print(1);
}
void test2(CalendarLongPressDetails data){
  print(1);
}
void test3(ViewChangedDetails data){
  print(1);
}
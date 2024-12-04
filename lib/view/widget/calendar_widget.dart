import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/view_model/view_model.dart';


class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarOptionBloc, CalendarOptionState>(builder: (context, state) {
      CalendarOption option = state.calendarOption;
      CalendarController controller = state.calendarController;
      return SfCalendar(
        controller: controller,
        view: option.viewType,
        firstDayOfWeek: option.firstDayOfWeek,
        monthViewSettings: option.getMonthViewSettings(),


        // use constant value
        viewHeaderStyle: viewHeaderStyle,
        headerHeight: 30,
        headerStyle: headerStyle,
        todayHighlightColor : Colors.blueAccent[100],
        scheduleViewSettings: scheduleViewSettings,
        onTap: (data) {},
        onLongPress: (data) {
          print(data);
        },
      );
    });
  }
}

const monthHeaderSettings =
    MonthHeaderSettings(height: 100, monthFormat: 'yyyy년 M월');
const scheduleViewSettings = ScheduleViewSettings(
    appointmentItemHeight: 70, monthHeaderSettings: monthHeaderSettings);
const viewHeaderStyle = ViewHeaderStyle(
    dayTextStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold));

final headerStyle = CalendarHeaderStyle(
    backgroundColor: Colors.blueAccent[100],
    textStyle: TextStyle(color: Colors.white, fontSize: 20));
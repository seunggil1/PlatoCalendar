import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/view_model/view_model.dart';
import 'package:plato_calendar/util/logger.dart';
import 'package:plato_calendar/view/widget_util/widget_util.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  static final logger = LoggerManager.getLogger('Model - PlatoAppointment');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarOptionBloc, CalendarOptionState>(
        builder: (context, state) {
      final CalendarOption option = state.calendarOption;
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
        todayHighlightColor: Colors.blueAccent[100],
        scheduleViewSettings: scheduleViewSettings,

        onTap: (data) {
          onTapCallBack(context, data, option);
        },
        onLongPress: (data) {
          onLongTapCallBack(context, data, option);
        },
      );
    });
  }
}

void onTapCallBack(
    BuildContext context, CalendarTapDetails tapDetail, CalendarOption option) {
  if (option.showAgenda) {
    if (tapDetail.targetElement == CalendarElement.appointment) {
      showMessage(context, 'Show Appointment Editor');
    }
  } else {
    if (option.calendarViewTypeIsMonth() &&
        tapDetail.targetElement == CalendarElement.calendarCell) {
      context.read<CalendarOptionBloc>().add(Update(CalendarOptionState(
          option.copyWith(viewType: CalendarView.schedule))));
    } else if (option.calendarViewTypeIsSchedule() &&
        tapDetail.targetElement == CalendarElement.appointment) {
      showMessage(context, 'show Appointment Editor');
    }
  }
}

void onLongTapCallBack(BuildContext context, CalendarLongPressDetails tapDetail,
    CalendarOption option) {
  if(tapDetail.targetElement == CalendarElement.appointment){

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

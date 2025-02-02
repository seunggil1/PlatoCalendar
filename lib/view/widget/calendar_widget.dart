import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';
import 'package:plato_calendar/view/widget/widget_util/widget_util.dart';
import 'package:plato_calendar/view_model/view_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  static final logger = LoggerManager.getLogger('Model - PlatoAppointment');

  @override
  Widget build(BuildContext context) {
    // 2가지 bloc을 사용하므로, Blocbuilder 대신 watch를 사용합니다.
    SyncfusionCalendarOptionState calendarOptionState =
        context.watch<SyncfusionCalendarOptionBloc>().state;
    List<PlatoAppointment> appointmentState =
        context.watch<GlobalPlatoAppointmentBloc>().state;

    final CalendarOption calendarOption = calendarOptionState.calendarOption;
    CalendarController calendarController =
        calendarOptionState.calendarController;
    final colorScheme = Theme.of(context).colorScheme;

    return SfCalendar(
      controller: calendarController,
      firstDayOfWeek: calendarOption.firstDayOfWeek,
      monthViewSettings: calendarOption.getMonthViewSettings(),
      dataSource: SfCalendarDataSource(appointmentState),
      viewHeaderStyle: getViewHeaderStyle(colorScheme),
      headerHeight: 40,
      headerStyle: getCalendarHeaderStyle(colorScheme),
      todayHighlightColor: colorScheme.primary,
      scheduleViewSettings: getScheduleViewSettings(colorScheme),
      initialDisplayDate: calendarController.displayDate,
      onTap: (CalendarTapDetails data) {
        onTapCallBack(context, data, calendarOptionState);
      },
      onLongPress: (CalendarLongPressDetails data) {
        onLongTapCallBack(context, data, calendarOptionState);
      },
    );
  }

  ViewHeaderStyle getViewHeaderStyle(ColorScheme colorScheme) {
    return ViewHeaderStyle(
        dayTextStyle: TextStyle(
            color: colorScheme.onSurface, fontWeight: FontWeight.bold));
  }

  CalendarHeaderStyle getCalendarHeaderStyle(ColorScheme colorScheme) {
    return CalendarHeaderStyle(
        backgroundColor: colorScheme.primaryContainer,
        textStyle:
            TextStyle(color: colorScheme.onPrimaryContainer, fontSize: 20));
  }

  ScheduleViewSettings getScheduleViewSettings(ColorScheme colorScheme) {
    return ScheduleViewSettings(
        appointmentItemHeight: 70,
        monthHeaderSettings: getMonthHeaderSettings(colorScheme));
  }

  MonthHeaderSettings getMonthHeaderSettings(ColorScheme colorScheme) {
    return MonthHeaderSettings(
        height: 90,
        monthFormat: 'yyyy년 M월',
        backgroundColor: colorScheme.secondaryContainer,
        monthTextStyle: TextStyle(color: colorScheme.onSecondaryContainer));
  }
}

void onTapCallBack(BuildContext context, CalendarTapDetails tapDetail,
    SyncfusionCalendarOptionState calendarOptionState) {
  if (calendarOptionState.calendarOption.showAgenda) {
    if (tapDetail.targetElement == CalendarElement.appointment) {
      showSnackBar(context, 'Show Appointment Editor');
    }
  } else {
    if (calendarOptionState.calendarViewTypeIsMonth() &&
        tapDetail.targetElement == CalendarElement.calendarCell) {
      context.read<SyncfusionCalendarOptionBloc>().add(
          SyncfusionCalendarDisplayOptionUpdate(
              calendarView: CalendarView.schedule,
              displayDatetime: tapDetail.date));
    } else if (calendarOptionState.calendarViewTypeIsSchedule() &&
        tapDetail.targetElement == CalendarElement.appointment) {
      showSnackBar(context, 'show Appointment Editor');
    }
  }
}

void onLongTapCallBack(BuildContext context, CalendarLongPressDetails tapDetail,
    SyncfusionCalendarOptionState calendarOptionState) {
  if (tapDetail.targetElement == CalendarElement.appointment) {}
}

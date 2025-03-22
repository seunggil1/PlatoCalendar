import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';
import 'package:plato_calendar/view_model/view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'appointment_editor/appointment_editor.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  static final _logger =
      LoggerManager.getLogger('View - widget - CalendarWidget');

  @override
  Widget build(BuildContext context) {
    // 2가지 bloc을 사용하므로, Blocbuilder 대신 watch를 사용합니다.
    SyncfusionCalendarOptionState calendarOptionState =
        context.watch<SyncfusionCalendarOptionBloc>().state;
    SyncfusionCalendarAppointmentState appointmentState =
        context.watch<SyncfusionCalendarAppointmentCubit>().state;

    List<PlatoAppointment> appointmentList = appointmentState.appointments;

    final CalendarOption calendarOption = calendarOptionState.calendarOption;
    CalendarController calendarController =
        calendarOptionState.calendarController;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    _logger.fine('CalendarWidget build');

    return SfCalendar(
      controller: calendarController,
      firstDayOfWeek: calendarOption.firstDayOfWeek,
      monthViewSettings: calendarOption.getMonthViewSettings(),
      dataSource: SfCalendarDataSource(appointmentList),
      viewHeaderStyle: getViewHeaderStyle(colorScheme),
      headerHeight: 40,
      headerStyle: getCalendarHeaderStyle(colorScheme, textTheme),
      todayHighlightColor: colorScheme.primary,
      scheduleViewSettings: getScheduleViewSettings(colorScheme),
      initialDisplayDate: calendarController.displayDate,
      onTap: (CalendarTapDetails data) async {
        onTapCallBack(context, data, calendarOptionState, appointmentState);
      },
      onLongPress: (CalendarLongPressDetails data) async {},
    );
  }

  ViewHeaderStyle getViewHeaderStyle(ColorScheme colorScheme) {
    return ViewHeaderStyle(
        dayTextStyle: TextStyle(
            color: colorScheme.onSurface, fontWeight: FontWeight.bold));
  }

  CalendarHeaderStyle getCalendarHeaderStyle(
      ColorScheme colorScheme, TextTheme textTheme) {
    return CalendarHeaderStyle(
        backgroundColor: colorScheme.primaryContainer,
        textStyle: textTheme.headlineSmall?.copyWith(
          color: colorScheme.primary,
          fontSize: 18.sp,
        ));
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

  void onTapCallBack(
      BuildContext context,
      CalendarTapDetails tapDetail,
      SyncfusionCalendarOptionState calendarOptionState,
      SyncfusionCalendarAppointmentState appointmentState) async {
    List<String> subjectCodeList = appointmentState.subjectCodeList;
    List<PlatoAppointment> appointmentList = appointmentState.appointments;

    if (calendarOptionState.calendarOption.showAgenda) {
      if (tapDetail.targetElement == CalendarElement.appointment) {
        final uid = tapDetail.appointments?.first.resourceIds.first ?? '';
        final appointment =
            appointmentList.firstWhereOrNull((element) => element.uid == uid);

        if (appointment != null) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AppointmentEditorDialog.fromPlatoAppointment(appointment,
                    subjectCodeList: subjectCodeList);
              });
        }
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
        final uid = tapDetail.appointments?.first.resourceIds.first ?? '';
        final appointment =
            appointmentList.firstWhereOrNull((element) => element.uid == uid);

        if (appointment != null) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AppointmentEditorDialog.fromPlatoAppointment(appointment,
                    subjectCodeList: subjectCodeList);
              });
        }
      }
    }
  }
}

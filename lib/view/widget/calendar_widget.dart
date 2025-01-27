import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';
import 'package:plato_calendar/view/widget/widget_util/widget_util.dart';
import 'package:plato_calendar/view_model/view_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

const monthHeaderSettings =
    MonthHeaderSettings(height: 100, monthFormat: 'yyyy년 M월');
const scheduleViewSettings = ScheduleViewSettings(
    appointmentItemHeight: 70, monthHeaderSettings: monthHeaderSettings);

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  static final logger = LoggerManager.getLogger('Model - PlatoAppointment');

  @override
  Widget build(BuildContext context) {
    CalendarOptionState calendarOptionState =
        context.watch<SyncfusionCalendarOptionBloc>().state;
    final CalendarOption calendarOption = calendarOptionState.calendarOption;
    CalendarController calendarController =
        calendarOptionState.calendarController;

    List<PlatoAppointment> appointmentState =
        context.watch<GlobalPlatoAppointmentBloc>().state;

    final colorScheme = Theme.of(context).colorScheme;

    return SfCalendar(
      controller: calendarController,
      view: calendarOption.viewType,
      firstDayOfWeek: calendarOption.firstDayOfWeek,
      monthViewSettings: calendarOption.getMonthViewSettings(),
      dataSource: SfCalendarDataSource(appointmentState),
      viewHeaderStyle: getViewHeaderStyle(colorScheme),
      headerHeight: 30,
      headerStyle: getCalendarHeaderStyle(colorScheme),
      todayHighlightColor: colorScheme.primary,
      scheduleViewSettings: scheduleViewSettings,
      onTap: (data) {
        onTapCallBack(context, data, calendarOption);
      },
      onLongPress: (data) {
        onLongTapCallBack(context, data, calendarOption);
      },
    );
  }
}

void onTapCallBack(
    BuildContext context, CalendarTapDetails tapDetail, CalendarOption option) {
  if (option.showAgenda) {
    if (tapDetail.targetElement == CalendarElement.appointment) {
      showSnackBar(context, 'Show Appointment Editor');
    }
  } else {
    if (option.calendarViewTypeIsMonth() &&
        tapDetail.targetElement == CalendarElement.calendarCell) {
      context.read<SyncfusionCalendarOptionBloc>().add(
          SyncfusionCalendarOptionUpdate(
              option.copyWith(viewType: CalendarView.schedule)));
    } else if (option.calendarViewTypeIsSchedule() &&
        tapDetail.targetElement == CalendarElement.appointment) {
      showSnackBar(context, 'show Appointment Editor');
    }
  }
}

void onLongTapCallBack(BuildContext context, CalendarLongPressDetails tapDetail,
    CalendarOption option) {
  if (tapDetail.targetElement == CalendarElement.appointment) {}
}

ViewHeaderStyle getViewHeaderStyle(ColorScheme colorScheme) {
  return ViewHeaderStyle(
      dayTextStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold));
}

CalendarHeaderStyle getCalendarHeaderStyle(ColorScheme colorScheme) {
  return CalendarHeaderStyle(
      backgroundColor: colorScheme.primary,
      textStyle: TextStyle(color: colorScheme.onPrimary, fontSize: 20));
}

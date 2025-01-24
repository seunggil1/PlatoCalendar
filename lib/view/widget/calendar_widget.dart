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
const viewHeaderStyle = ViewHeaderStyle(
    dayTextStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold));

final headerStyle = CalendarHeaderStyle(
    backgroundColor: Colors.blueAccent[100],
    textStyle: TextStyle(color: Colors.white, fontSize: 20));

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

    return SfCalendar(
      controller: calendarController,
      view: calendarOption.viewType,
      firstDayOfWeek: calendarOption.firstDayOfWeek,
      monthViewSettings: calendarOption.getMonthViewSettings(),
      dataSource: SfCalendarDataSource(appointmentState),

      // use constant value
      viewHeaderStyle: viewHeaderStyle,
      headerHeight: 30,
      headerStyle: headerStyle,
      todayHighlightColor: Colors.blueAccent[100],
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
      showMessage(context, 'Show Appointment Editor');
    }
  } else {
    if (option.calendarViewTypeIsMonth() &&
        tapDetail.targetElement == CalendarElement.calendarCell) {
      context.read<SyncfusionCalendarOptionBloc>().add(SyncfusionCalendarOptionUpdate(
          option.copyWith(viewType: CalendarView.schedule)));
    } else if (option.calendarViewTypeIsSchedule() &&
        tapDetail.targetElement == CalendarElement.appointment) {
      showMessage(context, 'show Appointment Editor');
    }
  }
}

void onLongTapCallBack(BuildContext context, CalendarLongPressDetails tapDetail,
    CalendarOption option) {
  if (tapDetail.targetElement == CalendarElement.appointment) {}
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/view_model/view_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import './widget/calendar_widget.dart';

class SyncfusionCalendarPage extends StatefulWidget {
  const SyncfusionCalendarPage({super.key});

  @override
  State<StatefulWidget> createState() => _SyncfusionCalendarPageState();
}

class _SyncfusionCalendarPageState extends State<SyncfusionCalendarPage> {
  @override
  void initState() {
    super.initState();
    bool showFinished = context
        .read<SyncfusionCalendarOptionBloc>()
        .state
        .calendarOption
        .showFinished;
    context
        .read<SyncfusionCalendarAppointmentCubit>()
        .loadPlatoAppointment(showFinished: showFinished);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncfusionCalendarOptionBloc,
        SyncfusionCalendarOptionState>(builder: (context, state) {
      return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, dynamic) async {
            // bool close = await confirmDialog(context);

            // CalendarViewType가 Schedule이면 Month로 변경
            if (state.calendarViewTypeIsSchedule()) {
              context.read<SyncfusionCalendarOptionBloc>().add(
                  SyncfusionCalendarDisplayOptionUpdate(
                      calendarView: CalendarView.month));
            } else {
              SystemNavigator.pop();
              // if(Platform.isIOS) exit(0);
            }
          },
          child: CalendarWidget());
    });
    // return BlocProvider(
  }
}

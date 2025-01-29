import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/view_model/view_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import './widget/calendar_widget.dart';

class SyncfusionCalendarPage extends StatelessWidget {
  const SyncfusionCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncfusionCalendarOptionBloc, SyncfusionCalendarOptionState>(
        builder: (context, state) {
      return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, dynamic) async {
            // bool close = await confirmDialog(context);
            CalendarOption calendarOption = state.calendarOption;

            // CalendarViewType가 Schedule이면 Month로 변경
            if (state.calendarViewTypeIsSchedule()) {
              context.read<SyncfusionCalendarOptionBloc>().add(
                  SyncfusionCalendarDisplayOptionUpdate(calendarView: CalendarView.month));
            } else {
              SystemNavigator.pop();
            }
          },
          child: CalendarWidget());
    });
    // return BlocProvider(
  }
}

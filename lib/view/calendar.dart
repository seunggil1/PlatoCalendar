import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/view_model/view_model.dart';

import './widget_util/widget_util.dart';
import './widget/calendar_widget.dart';

class PlatoCalendarPage extends StatelessWidget {
  const PlatoCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CalendarOptionBloc(),
        child: BlocBuilder<CalendarOptionBloc, CalendarOptionState>(builder: (context, state) {
          return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, dynamic) async {
                // bool close = await confirmDialog(context);
                CalendarOption option = state.calendarOption;

                // CalendarViewType가 Schedule이면 Month로 변경
                if(option.calendarViewTypeIsSchedule()){
                  context.read<CalendarOptionBloc>().add(
                      Update(CalendarOptionState(option.copyWith(viewType: CalendarView.month))
                  ));
                }else{
                  Navigator.of(context).maybePop(); // 뒤로 가기 수행
                }
              },
              child: CalendarWidget());
        }));
    // return BlocProvider(
  }
}

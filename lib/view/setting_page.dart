import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:plato_calendar/view_model/view_model.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final platoThemeCubit = context.read<PlatoThemeCubit>();
    final calendarOptionBloc = context.read<CalendarOptionBloc>();
    final option = calendarOptionBloc.state.calendarOption;
    return Column(
      children: [
        TextButton(
            onPressed: platoThemeCubit.setLightTheme,
            child: const Text('set light')),
        TextButton(
            onPressed: platoThemeCubit.setDarkTheme,
            child: const Text('set dark')),
        TextButton(
            onPressed: () {
              calendarOptionBloc.add(Update(
                  CalendarOptionState(option.copyWith(showAgenda: false))));
            },
            child: const Text('show Agenda false')),
        TextButton(
            onPressed: () {
              calendarOptionBloc.add(Update(
                  CalendarOptionState(option.copyWith(showAgenda: true))));
            },
            child: const Text('show Agenda true'))
      ],
    );
    // return BlocProvider(
  }
}

// class PlatoCalendar extends StatelessWidget {
//   const PlatoCalendar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

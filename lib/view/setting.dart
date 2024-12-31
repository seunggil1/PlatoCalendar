import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';
import 'package:plato_calendar/view_model/view_model.dart';

import 'widget/widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final platoThemeCubit = context.read<PlatoThemeCubit>();
    final calendarOptionBloc = context.read<CalendarOptionBloc>();
    final option = calendarOptionBloc.state.calendarOption;
    final platoAppointmentBloc = context.read<PlatoAppointmentBloc>();

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
              calendarOptionBloc.add(
                  CalendarOptionUpdate(option.copyWith(showAgenda: false)));
            },
            child: const Text('show Agenda false')),
        TextButton(
            onPressed: () {
              calendarOptionBloc
                  .add(CalendarOptionUpdate(option.copyWith(showAgenda: true)));
            },
            child: const Text('show Agenda true')),
        TextButton(
            onPressed: () {
              platoAppointmentBloc.add(PlatoAppointmentLoading());
            },
            child: const Text('update plato data')),
        TextButton(
            onPressed: () async {
              PlatoCredential? credential = await showDialog<PlatoCredential>(
                  context: context,
                  builder: (context) {
                    return const LoginDialog();
                  });
              if (credential != null) {
                await PlatoCredentialDB.write(credential);
              }
            },
            child: const Text('set user credential')),
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

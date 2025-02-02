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
    // final globalDisplayOptionBloc = context.read<GlobalDisplayOptionBloc>();
    final syncfusionCalendarOptionBloc =
        context.read<SyncfusionCalendarOptionBloc>();
    final option = syncfusionCalendarOptionBloc.state.calendarOption;
    final globalPlatoAppointmentBloc =
        context.read<GlobalPlatoAppointmentBloc>();

    return ListView(
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: ThemeSettingWidget()),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: SyncfusionCalendarSettingWidget()),
        TextButton(
            onPressed: () {
              syncfusionCalendarOptionBloc.add(SyncfusionCalendarOptionUpdate(
                  option.copyWith(showAgenda: false)));
            },
            child: const Text('show Agenda false')),
        TextButton(
            onPressed: () {
              syncfusionCalendarOptionBloc.add(SyncfusionCalendarOptionUpdate(
                  option.copyWith(showAgenda: true)));
            },
            child: const Text('show Agenda true')),
        TextButton(
            onPressed: () {
              globalPlatoAppointmentBloc.add(SyncPlatoAppointment());
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
        TextButton(
            onPressed: () {
              globalPlatoAppointmentBloc.add(DeleteAllPlatoAppointment());
            },
            child: const Text('Delete all plato appointment data')),
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

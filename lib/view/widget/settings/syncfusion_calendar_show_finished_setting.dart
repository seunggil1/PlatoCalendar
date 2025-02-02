import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/view_model/bloc/bloc.dart';

class SyncfusionCalendarShowFinishedSettingWidget extends StatelessWidget {
  const SyncfusionCalendarShowFinishedSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final calendarOption = context.select(
        (SyncfusionCalendarOptionBloc bloc) => bloc.state.calendarOption);

    return Container(
        color: colorScheme.surfaceContainerHighest,
        child: ListTile(
            leading: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '완료된 일정 표시',
                  style: theme.textTheme.bodyMedium?.copyWith(
                      // fontWeight: FontWeight.w100,
                      color: colorScheme.secondary),
                )),
            trailing: Transform.scale(
                scale: 0.8,
                child: Switch(
                    thumbIcon: WidgetStateProperty<Icon>.fromMap(
                      <WidgetStatesConstraint, Icon>{
                        WidgetState.selected: Icon(Icons.check),
                        WidgetState.any: Icon(Icons.close),
                      },
                    ),
                    value: calendarOption.showFinished,
                    onChanged: (bool value) {
                      context.read<SyncfusionCalendarOptionBloc>().add(
                          SyncfusionCalendarOptionUpdate(
                              calendarOption.copyWith(showFinished: value)));
                    }))));
  }
}

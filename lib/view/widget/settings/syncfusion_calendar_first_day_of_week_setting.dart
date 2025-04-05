// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:plato_calendar/etc/kr_localization.dart';
import 'package:plato_calendar/view_model/bloc/bloc.dart';

class SyncfusionCalendarFirstDayOfWeekSettingWidget extends StatelessWidget {
  const SyncfusionCalendarFirstDayOfWeekSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final calendarOption = context.select(
        (SyncfusionCalendarOptionBloc bloc) => bloc.state.calendarOption);

    const String title = '시작 요일';
    final String subtitle =
        '달력에서 한 주의 시작을 ${weekdayLocaleKR[calendarOption.firstDayOfWeek]}요일로 합니다';

    return Container(
        color: colorScheme.surfaceContainerHighest,
        child: Padding(
            padding: EdgeInsets.all(4.0),
            child: ListTile(
                title: Text(title,
                    style: textTheme.bodyMedium
                        ?.copyWith(color: colorScheme.secondary)),
                subtitle: Text(subtitle,
                    style: textTheme.bodySmall
                        ?.copyWith(color: colorScheme.secondary)),
                trailing: getDropdownButton(context))));
  }

  Widget getDropdownButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final calendarOption = context.select(
        (SyncfusionCalendarOptionBloc bloc) => bloc.state.calendarOption);

    return DropdownButton(
        underline: Container(
            height: 2, color: colorScheme.outline.withValues(alpha: 0.35)),
        value: calendarOption.firstDayOfWeek,
        items: weekdayLocaleKR.entries
            .map<DropdownMenuItem<int>>((e) => DropdownMenuItem<int>(
                value: e.key,
                child: Row(
                  children: [
                    SizedBox(width: 8.0),
                    Text(e.value,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: colorScheme.secondary))
                  ],
                )))
            .toList(),
        onChanged: (newValue) {
          context.read<SyncfusionCalendarOptionBloc>().add(
              SyncfusionCalendarOptionUpdate(
                  calendarOption.copyWith(firstDayOfWeek: newValue)));
        });
  }
}

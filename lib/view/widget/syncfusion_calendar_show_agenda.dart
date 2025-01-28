import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/view_model/view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class SyncfusionCalendarShowAgendaWidget extends StatelessWidget {
  const SyncfusionCalendarShowAgendaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
      return Card.outlined(
        color: colorScheme.secondaryContainer.withOpacity(1.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 그룹의 제목
              Text(
                '달력 종류',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
              const SizedBox(height: 12),
              _SyncfusionCalendarShowAgendaWidget(),
            ],
          ),
        ),
      );
  }
}
class _SyncfusionCalendarShowAgendaWidget extends StatelessWidget {
  const _SyncfusionCalendarShowAgendaWidget();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SyncfusionCalendarOptionBloc,
        SyncfusionCalendarOptionState, CalendarOption>(
      selector: (state) => state.calendarOption,
      builder: (BuildContext context, CalendarOption option) {
        final textTheme = Theme.of(context).textTheme;
        final colorScheme = Theme.of(context).colorScheme;
        return Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () => context.read<SyncfusionCalendarOptionBloc>().add(
                  SyncfusionCalendarOptionUpdate(
                      option.copyWith(showAgenda: true))),
              child: Card(
                color: colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: option.showAgenda
                        ? colorScheme.primary
                        : colorScheme.outlineVariant,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.view_agenda,
                            size: 20.sp,
                            color: option.showAgenda
                                ? colorScheme.primary
                                : colorScheme.outlineVariant,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '일정 통합형',
                            style: textTheme.titleSmall?.copyWith(
                              color: option.showAgenda
                                  ? colorScheme.primary
                                  : colorScheme.outlineVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '달력과 일정 목록을\n한 페이지에 표시합니다.',
                        textAlign: TextAlign.center,
                        style: textTheme.bodySmall?.copyWith(
                          color: option.showAgenda
                              ? colorScheme.primary
                              : colorScheme.outlineVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
            Expanded(
                child: InkWell(
              onTap: () => context.read<SyncfusionCalendarOptionBloc>().add(
                  SyncfusionCalendarOptionUpdate(
                      option.copyWith(showAgenda: false))),
              child: Card(
                color: colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: !option.showAgenda
                        ? colorScheme.primary
                        : colorScheme.outlineVariant,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 20.sp,
                            color: !option.showAgenda
                                ? colorScheme.primary
                                : colorScheme.outlineVariant,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '일정 분리형',
                            style: textTheme.titleSmall?.copyWith(
                              color: !option.showAgenda
                                  ? colorScheme.primary
                                  : colorScheme.outlineVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '달력에서 날짜를 선택하면\n일정 목록이 표시됩니다.',
                        textAlign: TextAlign.center,
                        style: textTheme.bodySmall?.copyWith(
                          color: !option.showAgenda
                              ? colorScheme.primary
                              : colorScheme.outlineVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        );
      },
    );
  }
}

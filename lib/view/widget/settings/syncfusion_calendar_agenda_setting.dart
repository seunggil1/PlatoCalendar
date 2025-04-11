// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// Project imports:
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/view_model/view_model.dart';

class SyncfusionCalendarAgendaSettingWidget extends StatelessWidget {
  const SyncfusionCalendarAgendaSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 그룹의 제목
            Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 4.0),
                child: Text(
                  '유형 설정',
                  style: theme.textTheme.bodyMedium?.copyWith(
                      // fontWeight: FontWeight.w100,
                      color: colorScheme.secondary),
                )),
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
        SyncfusionCalendarOptionState, SyncfusionCalendarOption>(
      selector: (state) => state.calendarOption,
      builder: (BuildContext context, SyncfusionCalendarOption option) {
        final textTheme = Theme.of(context).textTheme;
        final colorScheme = Theme.of(context).colorScheme;
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                                size: 18.sp,
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
                              fontSize: 14.sp,
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
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                                size: 18.sp,
                                color: !option.showAgenda
                                    ? colorScheme.primary
                                    : colorScheme.outlineVariant,
                              ),
                              Icon(
                                Icons.list_alt_outlined,
                                size: 18.sp,
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
                              fontSize: 14.sp,
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
            ));
      },
    );
  }
}

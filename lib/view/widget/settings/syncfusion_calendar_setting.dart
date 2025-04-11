// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'material_card.dart';
import 'syncfusion_calendar_agenda_setting.dart';
import 'syncfusion_calendar_first_day_of_week_setting.dart';
import 'syncfusion_calendar_show_finished_setting.dart';

class SyncfusionCalendarSettingWidget extends StatelessWidget {
  const SyncfusionCalendarSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialCard(
      title: '달력 설정',
      // subTitle: '지금 사용해보기',
      // secondSubTitle: '지금 사용해보기 2',
      isFoldable: true,
      children: [
        SyncfusionCalendarShowFinishedSettingWidget(),
        SyncfusionCalendarFirstDayOfWeekSettingWidget(),
        SyncfusionCalendarAgendaSettingWidget(),
      ],
    );
  }
}

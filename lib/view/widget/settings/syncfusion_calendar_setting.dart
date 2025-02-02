import 'package:flutter/material.dart';

import 'material_card.dart';
import 'syncfusion_calendar_agenda_setting.dart';

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
        SyncfusionCalendarAgendaSettingWidget(),
      ],
    );
  }
}

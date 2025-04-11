// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:plato_calendar/service/service.dart';
import 'package:plato_calendar/view_model/view_model.dart';
import 'package:plato_calendar/widget_util/widget_util.dart';
import 'material_card.dart';

class DebugSettingWidget extends StatefulWidget {
  const DebugSettingWidget({super.key});

  @override
  State<DebugSettingWidget> createState() => _DebugSettingWidget();
}

class _DebugSettingWidget extends State<DebugSettingWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialCard(title: '개발자 도구', isFoldable: true, children: [
      FilledButton.tonal(
        onPressed: () {
          context.read<PlatoSyncInfoBloc>().add(PlatoLogout());
        },
        child: const Text('Plato 계정 & 일정 전체 삭제',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      FilledButton.tonal(
        onPressed: () async {
          try {
            showSnackBar(context, '일정 데이터 추가 중..');
            await AppSyncHandler.addTestPlatoAppointment();
            if (context.mounted) {
              showSnackBar(context, '일정 데이터 추가 완료');
              context.read<PlatoSyncInfoBloc>().add(PlatoSync());
            }
          } catch (e) {
            if (context.mounted) {
              showSnackBar(context, e.toString());
            }
          }
        },
        child: const Text('테스트 데이터 추가',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    ]);
  }
}

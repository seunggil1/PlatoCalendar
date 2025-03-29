import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/view_model/view_model.dart';

import 'material_card.dart';

class DebugSettingWidget extends StatelessWidget {
  const DebugSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialCard(title: '개발자 도구', isFoldable: true, children: [
      FilledButton(
        onPressed: () {
          context.read<PlatoSyncInfoBloc>().add(PlatoLogout());
        },
        child: const Text('Plato 계정 & 일정 전체 삭제',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      TextButton(onPressed: () {}, child: const Text('일정 전체 삭제')),
    ]);
  }
}

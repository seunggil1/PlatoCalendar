// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// Project imports:
import 'package:plato_calendar/etc/kr_localization.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';
import 'package:plato_calendar/view_model/bloc/bloc.dart';
import 'login_dialog.dart';
import 'material_card.dart';

final _logger = LoggerManager.getLogger('View - PlatoLoginSetting');

class PlatoLoginSetting extends StatelessWidget {
  const PlatoLoginSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlatoSyncInfoBloc, PlatoSyncInfoState>(
        builder: (context, state) {
      PlatoCredential? platoCredential = state.platoCredential;
      SyncInfo? syncInfo = state.syncInfo;
      SyncStatusType syncStatusType = state.syncStatus;

      return MaterialCard(
          key: Key(platoCredential.toString() +
              syncInfo.toString() +
              syncStatusType.toString()),
          title: '플라토 설정',
          isFoldable: false,
          subTitle: (platoCredential == null)
              ? null
              : '일정 동기화 정보 : ${_getSyncInfoText(platoCredential, syncInfo)}',
          children: [
            (platoCredential == null)
                ? BeforeLoginWidget()
                : AfterLoginWidget(syncStatusType),
            const SizedBox(height: 6),
          ]);
    });
  }

  String _getSyncInfoText(PlatoCredential? credential, SyncInfo? info) {
    if (credential == null) {
      return 'Plato 로그인 필요';
    } else if (info == null) {
      return '동기화 기록 없음';
    } else if (!info.success) {
      return '동기화 실패 - ${info.failReason}';
    } else {
      return getFullDateTimeLocaleKR(info.platoSyncTime);
    }
  }
}

class BeforeLoginWidget extends StatefulWidget {
  const BeforeLoginWidget({super.key});

  @override
  State<StatefulWidget> createState() => _BeforeLoginWidget();
}

class _BeforeLoginWidget extends State<BeforeLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 5),
          Text('일정 동기화 정보 ', style: TextStyle(fontSize: 16.sp)),
          Expanded(
              child: Text(': Plato 로그인 필요',
                  style:
                      TextStyle(fontSize: 15.sp, fontStyle: FontStyle.italic))),
          FilledButton(
            onPressed: () async {
              final bloc = context.read<PlatoSyncInfoBloc>();
              final credential = await showDialog<PlatoCredential>(
                  context: context,
                  builder: (context) {
                    return const LoginDialog();
                  });

              if (credential != null) {
                bloc.add(PlatoLogin(credential));
              }
            },
            child: const Text('로그인',
                style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}

class AfterLoginWidget extends StatelessWidget {
  final SyncStatusType syncStatusType;

  const AfterLoginWidget(this.syncStatusType, {super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
        leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              '일정 수동 업데이트',
              style: textTheme.bodyMedium,
            )),
        trailing: (syncStatusType == SyncStatusType.syncing)
            ? _SyncingWidget()
            : _SyncWidget());
  }
}

class _SyncWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
        onPressed: () {
          context.read<PlatoSyncInfoBloc>().add(PlatoSync());
        },
        child: Text(' 동기화 '));
  }
}

class _SyncingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(onPressed: null, child: Text('동기화 중'));
  }
}

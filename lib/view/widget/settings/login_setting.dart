import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';
import 'package:plato_calendar/view_model/cubit/cubit.dart';

import 'login_dialog.dart';
import 'material_card.dart';

class LoginSetting extends StatelessWidget {
  const LoginSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlatoSyncInfoCubit, PlatoSyncInfo>(
        builder: (context, state) {
      PlatoCredential? platoCredential = state.platoCredential;
      SyncInfo? syncInfo = state.syncInfo;

      return MaterialCard(title: '플라토 설정', isFoldable: false, children: [
        _BeforeLoginWidget(),
        const SizedBox(height: 6),
      ]);
    });
  }
}

class _BeforeLoginWidget extends StatelessWidget {
  const _BeforeLoginWidget();

  @override
  Widget build(BuildContext context) {
    return ListTile(
        minLeadingWidth: 20,
        contentPadding: const EdgeInsets.fromLTRB(16, 5, 5, 5),
        leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.people_alt, color: Colors.blueAccent[100])
            ]),
        title: const Text('Plato 계정'),
        trailing: Container(
            padding: EdgeInsets.all(0),
            width: 160,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(child: Text('Sync')),
                  TextButton(
                      onPressed: () async {
                        PlatoCredential? credential =
                            await showDialog<PlatoCredential>(
                                context: context,
                                builder: (context) {
                                  return const LoginDialog();
                                });
                        if (credential != null) {
                          await PlatoCredentialDB.write(credential);
                        }
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(0),
                          width: 85,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent[100],
                              borderRadius: BorderRadius.circular(10)),
                          child: Text('로그인',
                              style: TextStyle(color: Colors.white))))
                ])));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:plato_calendar/view/view.dart';
import 'package:plato_calendar/view_model/view_model.dart';

Widget getWideMainPage(BuildContext context, int tapIndex) {
  return ResponsiveSizer(builder: (context, orientation, screenType) {
    return Scaffold(
        appBar: tapIndex != 1
            ? null
            : AppBar(
                title: Text(
                  '설정',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
                elevation: 1.0,
                shadowColor: Theme.of(context).colorScheme.shadow,
                centerTitle: false,
              ),
        body: SafeArea(
            child: tapIndex == 0
                ? Row(
                    children: [
                      Expanded(
                        flex: 1, // 좌측: 달력
                        child: SyncfusionCalendarPage(),
                      ),
                      VerticalDivider(width: 1, color: Colors.grey[300]),
                      Expanded(
                        flex: 1, // 우측: 할일
                        child: TaskCheckListPage(),
                      ),
                    ],
                  )
                : SettingPage()),
        bottomNavigationBar: NavigationBar(
            selectedIndex: tapIndex,
            onDestinationSelected: (int nextTabIndex) {
              context
                  .read<GlobalDisplayOptionBloc>()
                  .add(ChangeTapIndex(nextTabIndex));
            },
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.calendar_today_outlined), label: '달력'),
              NavigationDestination(icon: Icon(Icons.settings), label: '설정'),
            ]));
  });
}

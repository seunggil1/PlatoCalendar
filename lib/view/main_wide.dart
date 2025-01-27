import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:plato_calendar/view/view.dart';
import 'package:plato_calendar/view_model/view_model.dart';

Widget getWideMainPage(BuildContext context, int tapIndex) {
  return Scaffold(
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
              : DebugSettingPage()),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueAccent[100],
          unselectedItemColor: Colors.grey[400]!.withOpacity(1),
          currentIndex: tapIndex,
          onTap: (int nextTabIndex) {
            context
                .read<GlobalDisplayOptionBloc>()
                .add(ChangeTapIndex(nextTabIndex));
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined), label: '달력'),
            BottomNavigationBarItem(
                icon: Icon(Icons.my_library_books_outlined), label: 'DEBUG'),
          ]));
}

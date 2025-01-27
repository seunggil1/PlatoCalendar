import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:plato_calendar/view/view.dart';
import 'package:plato_calendar/view_model/view_model.dart';

Widget getDefaultMainPage(BuildContext context, int tapIndex) {
  return Scaffold(
      body: SafeArea(
          child: IndexedStack(index: tapIndex, children: const [
        SyncfusionCalendarPage(),
        TaskCheckListPage(),
        DebugSettingPage()
      ])),
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
                icon: Icon(Icons.my_library_books_outlined), label: '할일'),
            BottomNavigationBarItem(
                icon: Icon(Icons.my_library_books_outlined), label: 'DEBUG'),
          ]));
}

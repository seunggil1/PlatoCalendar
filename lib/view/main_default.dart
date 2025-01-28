import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:plato_calendar/view/view.dart';
import 'package:plato_calendar/view_model/view_model.dart';

Widget getDefaultMainPage(BuildContext context, int tapIndex) {
  return Scaffold(
      appBar: tapIndex != 2
          ? null
          : AppBar(
              title: Text(
                '설정',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              elevation: 1.0,
              shadowColor: Theme.of(context).colorScheme.shadow,
            ),
      body: SafeArea(
          child: IndexedStack(index: tapIndex, children: const [
        SyncfusionCalendarPage(),
        TaskCheckListPage(),
        DebugSettingPage()
      ])),
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
            NavigationDestination(
                icon: Icon(Icons.my_library_books_outlined), label: '할일'),
            NavigationDestination(
                icon: Icon(Icons.settings), label: '설정'),
          ]));
}

import 'package:flutter/material.dart';
import 'package:plato_calendar/util/bloc_observer.dart';
import 'package:plato_calendar/util/logger.dart';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/view/calendar.dart';
import 'package:plato_calendar/view/view.dart';
import 'package:plato_calendar/view_model/cubit/bottom_navigation.dart';

// https://bloclibrary.dev/ko/architecture/
void main() {
  final logger = LoggerManager.getLogger('main');
  initBloc();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;

  @override
  State<MainPage> createState() => MainBlocPage();
}

class MainBlocPage extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavigationCubit(),
      child: _MainBlocPage(),
    );
  }
}

class _MainBlocPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SelectedTab selectedTab =
        context.select((BottomNavigationCubit cubit) => cubit.state.tab);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Test'),
        ),
        body: IndexedStack(
          index: selectedTab.index,
          children: const [PlatoCalendarPage(), TodoPage()],
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blueAccent[100],
            unselectedItemColor: Colors.grey[400]!.withOpacity(1),
            currentIndex: selectedTab.index,
            onTap: (int tabIndex) {
              context
                  .read<BottomNavigationCubit>()
                  .setTab(SelectedTab.values[tabIndex]);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined), label: '달력'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.my_library_books_outlined), label: '할일'),
            ]));
  }
}

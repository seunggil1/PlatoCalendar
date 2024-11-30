import 'package:flutter/material.dart';
import 'package:plato_calendar/util/bloc_observer.dart';
import 'package:plato_calendar/util/logger.dart';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:plato_calendar/view/view.dart';
import 'package:plato_calendar/view_model/view_model.dart';

// https://bloclibrary.dev/ko/architecture/
void main() {
  final logger = LoggerManager.getLogger('main');
  initBloc();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Provide Cubit.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<BottomNavigationCubit>(
          create: (BuildContext context) => BottomNavigationCubit()),
      BlocProvider<PlatoThemeCubit>(
          create: (BuildContext context) => PlatoThemeCubit())
    ], child: const MaterialThemePage());
  }
}

class MaterialThemePage extends StatelessWidget {
  const MaterialThemePage({super.key});

  // Set theme.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlatoThemeCubit, PlatoTheme>(builder: (context, state) {
      return MaterialApp(
          theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.blue, brightness: Brightness.light)),
          darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.blueGrey, brightness: Brightness.dark)),
          themeMode: state.platoTheme,
          home: const MainBlocPage());
    });
  }
}

class MainBlocPage extends StatelessWidget {
  const MainBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectedTab selectedTab =
        context.select((BottomNavigationCubit cubit) => cubit.state.tab);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
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

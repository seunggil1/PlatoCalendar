import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/calendar_option_db.dart';
import 'package:plato_calendar/model_repository/global_display_option_db.dart';
import 'package:plato_calendar/util/util.dart';
import 'package:plato_calendar/view/view.dart';
import 'package:plato_calendar/view_model/view_model.dart';

// 앱 시작전 호출되어야 함.
class Setup {
  static late GlobalDisplayOption globalDisplayOption;
  static late CalendarOption calendarOption;
}

void main() async {
  final logger = LoggerManager.getLogger('main');
  setupBlocLogger();
  WidgetsFlutterBinding.ensureInitialized();

  // 세로 모드 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Future.wait([GlobalDisplayOptionDB.read(), CalendarOptionDB.read()])
      .then((List value) {
    Setup.globalDisplayOption = value[0];
    Setup.calendarOption = value[1];
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Provide Cubit.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<GlobalDisplayOptionBloc>(
          create: (BuildContext context) =>
              GlobalDisplayOptionBloc(Setup.globalDisplayOption)),
      BlocProvider<SyncfusionCalendarOptionBloc>(
          create: (BuildContext context) =>
              SyncfusionCalendarOptionBloc(Setup.calendarOption)),
      BlocProvider<TaskCheckListBloc>(
          create: (BuildContext context) => TaskCheckListBloc()),
      BlocProvider<GlobalPlatoAppointmentBloc>(
          create: (BuildContext context) => GlobalPlatoAppointmentBloc(
              taskCheckListBloc: context.read<TaskCheckListBloc>()))
    ], child: const MaterialThemePage());
  }
}

class MaterialThemePage extends StatelessWidget {
  const MaterialThemePage({super.key});

  // Set theme.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalDisplayOptionBloc, GlobalDisplayOption>(
        builder: (context, state) {
      return MaterialApp(
          theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.blue, brightness: Brightness.light)),
          darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.blueGrey, brightness: Brightness.dark)),
          themeMode: state.themeMode,
          home: const InitStatefulPage());
    });
  }
}

class InitStatefulPage extends StatefulWidget {
  const InitStatefulPage({super.key});

  @override
  State<InitStatefulPage> createState() => MainBlocPage();
}

class MainBlocPage extends State<InitStatefulPage> {
  @override
  void initState() {
    super.initState();
    context.read<GlobalPlatoAppointmentBloc>().add(LoadPlatoAppointment());
    // BlocProvider.of<GlobalPlatoAppointmentBloc>(context).add(LoadPlatoAppointment());
  }

  @override
  Widget build(BuildContext context) {
    // final SelectedTab selectedTab = context.select((BottomNavigationCubit cubit) => cubit.state.tab);
    return BlocBuilder<GlobalDisplayOptionBloc, GlobalDisplayOption>(
        builder: (context, state) {
      final isWideScreen = MediaQuery.of(context).size.width > 600;
      return isWideScreen
          ? getWideMainPage(context, state.tapIndex)
          : getDefaultMainPage(context, state.tapIndex);
    });
  }
}

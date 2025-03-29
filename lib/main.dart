import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:plato_calendar/etc/theme_seed_color.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/calendar_option_db.dart';
import 'package:plato_calendar/model_repository/global_display_option_db.dart';
import 'package:plato_calendar/model_repository/plato_credential_db.dart';
import 'package:plato_calendar/model_repository/sync_info_db.dart';
import 'package:plato_calendar/util/util.dart';
import 'package:plato_calendar/view/view.dart';
import 'package:plato_calendar/view_model/view_model.dart';

// 앱 시작전 호출되어야 함.
class Setup {
  static late GlobalDisplayOption globalDisplayOption;
  static late CalendarOption calendarOption;
  static late PlatoCredential? platoCredential;
  static late SyncInfo? syncInfo;
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
  await Future.wait([
    GlobalDisplayOptionDB.read(),
    CalendarOptionDB.read(),
    PlatoCredentialDB.read(),
    SyncInfoDB.read()
  ]).then((List value) {
    Setup.globalDisplayOption = value[0];
    Setup.calendarOption = value[1];
    Setup.platoCredential = value[2];
    Setup.syncInfo = value[3];
  });
  logger.fine('GlobalDisplayOption: ${Setup.globalDisplayOption}');
  logger.fine('CalendarOption: ${Setup.calendarOption}');
  logger.fine('PlatoCredential: ${Setup.platoCredential?.username}');
  logger.fine('SyncInfo: ${Setup.syncInfo}');
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
      BlocProvider<TodoListBloc>(
          create: (BuildContext context) => TodoListBloc()),
      BlocProvider<PlatoSyncInfoBloc>(
          create: (BuildContext context) => PlatoSyncInfoBloc(
              platoCredential: Setup.platoCredential,
              syncInfo: Setup.syncInfo)),
      BlocProvider<SyncfusionCalendarAppointmentCubit>(
          create: (BuildContext context) =>
              SyncfusionCalendarAppointmentCubit())
    ], child: const MaterialThemePage());
  }
}

class MaterialThemePage extends StatelessWidget {
  const MaterialThemePage({super.key});

  // Set theme.
  @override
  Widget build(BuildContext context) {
    final themeMode =
        context.select((GlobalDisplayOptionBloc bloc) => bloc.state.themeMode);
    final themeSeedColorIndex = context.select(
        (GlobalDisplayOptionBloc bloc) => bloc.state.themeSeedColorIndex);
    return MaterialApp(
        supportedLocales: [
          const Locale('ko', 'KR'),
          const Locale('en', 'US'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
                seedColor: themeSeedColors[themeSeedColorIndex],
                brightness: Brightness.light),
            useMaterial3: true),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
                seedColor: themeSeedColors[themeSeedColorIndex],
                brightness: Brightness.dark),
            useMaterial3: true),
        themeMode: themeMode,
        home: const InitStatefulPage());
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
  }

  @override
  Widget build(BuildContext context) {
    final tapIndex =
        context.select((GlobalDisplayOptionBloc bloc) => bloc.state.tapIndex);
    final isWideScreen = MediaQuery.of(context).size.width > 600;
    return isWideScreen
        ? getWideMainPage(context, tapIndex)
        : getDefaultMainPage(context, tapIndex);
  }
}

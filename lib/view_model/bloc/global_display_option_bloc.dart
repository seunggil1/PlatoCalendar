import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';

import './bloc_event/bloc_event.dart';

class GlobalDisplayOptionBloc
    extends Bloc<GlobalDisplayOptionEvent, GlobalDisplayOption> {
  GlobalDisplayOptionBloc(GlobalDisplayOption? init)
      : super(init ?? GlobalDisplayOption()) {
    on<GlobalDisplayOptionInitial>((event, emit) async {
      final option = await GlobalDisplayOptionDB.read();
      emit(option);
    });
    on<ChangeTapIndex>((event, emit) async {
      final nextState = state.copyWith(tapIndex: event.tapIndex);
      await GlobalDisplayOptionDB.write(nextState);
      emit(nextState);
    });
    on<SetLightTheme>((event, emit) async {
      final nextState = state.copyWith(themeMode: ThemeMode.light);
      await GlobalDisplayOptionDB.write(nextState);
      emit(nextState);
    });
    on<SetDarkTheme>((event, emit) async {
      final nextState = state.copyWith(themeMode: ThemeMode.dark);
      await GlobalDisplayOptionDB.write(nextState);
      emit(nextState);
    });
    on<SetSystemTheme>((event, emit) async {
      final nextState = state.copyWith(themeMode: ThemeMode.system);
      await GlobalDisplayOptionDB.write(nextState);
      emit(nextState);
    });
    on<ChangeThemeSeedColor>((event, emit) async {
      final nextState = state.copyWith(themeSeedColorIndex: event.themeSeedColor);
      await GlobalDisplayOptionDB.write(nextState);
      emit(nextState);
    });
  }
}

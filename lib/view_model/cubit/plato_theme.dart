// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// final class PlatoTheme extends Equatable {
//   const PlatoTheme({this.platoTheme = ThemeMode.system});
//
//   final ThemeMode platoTheme;
//
//   @override
//   List<Object> get props => [platoTheme];
// }
//
// class PlatoThemeCubit extends Cubit<PlatoTheme> {
//   PlatoThemeCubit() : super(const PlatoTheme());
//
//   void setLightTheme() => emit(const PlatoTheme(platoTheme: ThemeMode.light));
//
//   void setDarkTheme() => emit(const PlatoTheme(platoTheme: ThemeMode.dark));
//
//   void setSystemTheme() => emit(const PlatoTheme(platoTheme: ThemeMode.system));
// }

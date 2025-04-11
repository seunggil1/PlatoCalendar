// Package imports:
import 'package:equatable/equatable.dart';

sealed class GlobalDisplayOptionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GlobalDisplayOptionUpdate extends GlobalDisplayOptionEvent {}

class ChangeTapIndex extends GlobalDisplayOptionEvent {
  final int tapIndex;

  ChangeTapIndex(this.tapIndex);

  @override
  List<Object?> get props => [tapIndex];
}

class ChangeThemeSeedColor extends GlobalDisplayOptionEvent {
  final int themeSeedColor;

  ChangeThemeSeedColor(this.themeSeedColor);

  @override
  List<Object?> get props => [themeSeedColor];
}

class SetLightTheme extends GlobalDisplayOptionEvent {}

class SetDarkTheme extends GlobalDisplayOptionEvent {}

class SetSystemTheme extends GlobalDisplayOptionEvent {}

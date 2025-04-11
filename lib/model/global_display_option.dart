// Flutter imports:
import 'package:flutter/material.dart' as flutter_material;

// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'table/table.dart';

class GlobalDisplayOption {
  int? id;

  int tapIndex = 0;

  flutter_material.ThemeMode themeMode = flutter_material.ThemeMode.system;
  int themeSeedColorIndex = 0;

  DateTime dbTimestamp = DateTime.now();

  GlobalDisplayOption copyWith(
      {int? tapIndex,
      flutter_material.ThemeMode? themeMode,
      int? themeSeedColorIndex}) {
    return GlobalDisplayOption()
      ..tapIndex = tapIndex ?? this.tapIndex
      ..themeMode = themeMode ?? this.themeMode
      ..themeSeedColorIndex = themeSeedColorIndex ?? this.themeSeedColorIndex;
  }

  @override
  int get hashCode => Object.hash(tapIndex, themeMode);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is GlobalDisplayOption &&
        other.tapIndex == tapIndex &&
        other.themeMode == themeMode &&
        other.themeSeedColorIndex == themeSeedColorIndex;
  }

  @override
  String toString() {
    return 'GlobalDisplayOption{tapIndex: $tapIndex, themeMode: $themeMode, themeSeedColor: $themeSeedColorIndex}';
  }
}

extension GlobalDisplayOptionMapper on GlobalDisplayOption {
  GlobalOptionTableData _toData() {
    return GlobalOptionTableData(
      id: id ?? 0,
      tapIndex: tapIndex,
      themeMode: themeMode,
      themeSeedColorIndex: themeSeedColorIndex,
      dbTimestamp: dbTimestamp,
    );
  }

  GlobalOptionTableCompanion toSchema() {
    return GlobalOptionTableCompanion(
      tapIndex: Value(tapIndex),
      themeMode: Value(themeMode),
      themeSeedColorIndex: Value(themeSeedColorIndex),
      dbTimestamp: Value(dbTimestamp),
    );
  }
}

extension GlobalDisplayOptionTableDataMapper on GlobalOptionTableData {
  GlobalDisplayOption toModel() {
    return GlobalDisplayOption()
      ..id = id
      ..tapIndex = tapIndex
      ..themeMode = themeMode
      ..themeSeedColorIndex = themeSeedColorIndex
      ..dbTimestamp = dbTimestamp;
  }
}

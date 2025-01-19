import 'package:drift/drift.dart';
import 'package:flutter/material.dart' as flutter_material;

import 'table/table.dart';

class GlobalDisplayOption {
  int? id;

  int tapIndex = 0;

  flutter_material.ThemeMode themeMode = flutter_material.ThemeMode.system;

  DateTime dbTimestamp = DateTime.now();

  GlobalDisplayOption copyWith({
    int? tapIndex,
    flutter_material.ThemeMode? themeMode,
  }) {
    return GlobalDisplayOption()
      ..tapIndex = tapIndex ?? this.tapIndex
      ..themeMode = themeMode ?? this.themeMode;
  }

  @override
  int get hashCode => Object.hash(tapIndex, themeMode);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is GlobalDisplayOption &&
        other.tapIndex == tapIndex &&
        other.themeMode == themeMode;
  }

  @override
  String toString() {
    return 'GlobalDisplayOption{tapIndex: $tapIndex, themeMode: $themeMode}';
  }
}

extension GlobalDisplayOptionMapper on GlobalDisplayOption {
  GlobalOptionTableData _toData() {
    return GlobalOptionTableData(
      id: id ?? 0,
      tapIndex: tapIndex,
      themeMode: themeMode,
      dbTimestamp: dbTimestamp,
    );
  }

  GlobalOptionTableCompanion toSchema() {
    return GlobalOptionTableCompanion(
      tapIndex: Value(tapIndex),
      themeMode: Value(themeMode),
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
      ..dbTimestamp = dbTimestamp;
  }
}

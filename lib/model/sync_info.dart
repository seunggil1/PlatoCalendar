import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'table/table.dart';

class SyncInfo {
  int? id;
  DateTime platoSyncTime = DateTime.now();

  SyncInfo();

  @override
  int get hashCode => Object.hash(id, platoSyncTime);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is SyncInfo && other.id == id && other.platoSyncTime == platoSyncTime;
  }

  @override
  String toString() {
    return 'SyncInfo{id: $id, syncTime: $platoSyncTime}';
  }
}

extension SyncInfoMapper on SyncInfo {
  SyncInfoTableData _toData() {
    return SyncInfoTableData(
      id: id ?? 0,
      platoSyncTime: platoSyncTime,
    );
  }

  SyncInfoTableCompanion toSchema() {
    return SyncInfoTableCompanion(
      platoSyncTime: Value(platoSyncTime),
    );
  }
}

extension SyncInfoTableMapper on SyncInfoTableData {
  SyncInfo toModel() {
    return SyncInfo()
      ..id = id
      ..platoSyncTime = platoSyncTime;
  }
}
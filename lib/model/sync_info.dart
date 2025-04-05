// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'table/table.dart';

class SyncInfo {
  int? id;
  bool success = true;
  DateTime platoSyncTime = DateTime.now();

  String failReason = '';

  SyncInfo();

  @override
  int get hashCode => Object.hash(id, platoSyncTime);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is SyncInfo &&
        other.id == id &&
        other.platoSyncTime == platoSyncTime;
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
      success: success,
      platoSyncTime: platoSyncTime,
      failReason: failReason,
    );
  }

  SyncInfoTableCompanion toSchema() {
    return SyncInfoTableCompanion(
      success: Value(success),
      platoSyncTime: Value(platoSyncTime),
      failReason: Value(failReason),
    );
  }
}

extension SyncInfoTableMapper on SyncInfoTableData {
  SyncInfo toModel() {
    return SyncInfo()
      ..id = id
      ..success = success
      ..platoSyncTime = platoSyncTime
      ..failReason = failReason;
  }
}

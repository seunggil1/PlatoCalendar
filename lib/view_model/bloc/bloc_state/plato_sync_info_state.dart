// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:plato_calendar/model/model.dart';

enum SyncStatusType { syncing, synced }

final class PlatoSyncInfoState extends Equatable {
  final PlatoCredential? platoCredential;
  final SyncInfo? syncInfo;
  final SyncStatusType syncStatus;

  const PlatoSyncInfoState({
    required this.platoCredential,
    required this.syncInfo,
    this.syncStatus = SyncStatusType.synced,
  });

  PlatoSyncInfoState copyWith({
    PlatoCredential? platoCredential,
    SyncInfo? syncInfo,
    SyncStatusType? syncStatus,
  }) {
    return PlatoSyncInfoState(
      platoCredential: platoCredential ?? this.platoCredential,
      syncInfo: syncInfo ?? this.syncInfo,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  @override
  List<Object> get props =>
      [syncInfo ?? 'None', platoCredential ?? 'None', syncStatus];
}

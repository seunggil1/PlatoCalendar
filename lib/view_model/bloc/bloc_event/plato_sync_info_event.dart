// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:plato_calendar/model/model.dart';

sealed class PlatoSyncInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlatoLogin extends PlatoSyncInfoEvent {
  final PlatoCredential platoCredential;

  PlatoLogin(this.platoCredential);

  @override
  List<Object?> get props => ['Login'];
}

class PlatoLogout extends PlatoSyncInfoEvent {
  @override
  List<Object?> get props => ['Logout'];
}

class PlatoSync extends PlatoSyncInfoEvent {
  @override
  List<Object?> get props => ['Syncing'];
}

class PlatoSyncFinished extends PlatoSyncInfoEvent {
  @override
  List<Object?> get props => ['SyncFinished'];
}

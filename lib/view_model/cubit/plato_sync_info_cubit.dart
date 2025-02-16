import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';

final class PlatoSyncInfo extends Equatable {
  const PlatoSyncInfo({
    required this.platoCredential,
    required this.syncInfo,
  });

  final PlatoCredential? platoCredential;
  final SyncInfo? syncInfo;

  @override
  List<Object> get props => [syncInfo ?? 'None', platoCredential ?? 'None'];
}

class PlatoSyncInfoCubit extends Cubit<PlatoSyncInfo> {
  PlatoSyncInfoCubit({required platoCredential, required syncInfo})
      : super(PlatoSyncInfo(
            platoCredential: platoCredential, syncInfo: syncInfo));
}

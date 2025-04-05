// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:plato_calendar/model_repository/model_repository.dart';
import 'package:plato_calendar/service/service.dart';
import 'package:plato_calendar/view_model/bloc/bloc.dart';

class PlatoSyncInfoBloc extends Bloc<PlatoSyncInfoEvent, PlatoSyncInfoState> {
  PlatoSyncInfoBloc({required platoCredential, required syncInfo})
      : super(PlatoSyncInfoState(
            platoCredential: platoCredential, syncInfo: syncInfo)) {
    on<PlatoLogin>((event, emit) async {
      await PlatoCredentialDB.write(event.platoCredential);
      emit(PlatoSyncInfoState(
          platoCredential: event.platoCredential, syncInfo: syncInfo));
    });

    on<PlatoLogout>((event, emit) async {
      await Future.wait(
          [PlatoCredentialDB.deleteAll(), PlatoAppointmentDB.deleteAll()]);

      emit(PlatoSyncInfoState(platoCredential: null, syncInfo: state.syncInfo));
    });

    on<PlatoSync>((event, emit) async {
      emit(state.copyWith(syncStatus: SyncStatusType.syncing));

      await AppSyncHandler.sync();

      emit(PlatoSyncInfoState(
          platoCredential: state.platoCredential,
          syncInfo: await SyncInfoDB.read(),
          syncStatus: SyncStatusType.synced));
    });
  }
}

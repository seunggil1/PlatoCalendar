import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';


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

  Future<void> loginPlato(PlatoCredential platoCredential) async {
    await PlatoCredentialDB.write(platoCredential);
    emit(PlatoSyncInfo(
        platoCredential: platoCredential, syncInfo: state.syncInfo));
  }

  Future<void> logoutPlato() async {
    await PlatoCredentialDB.deleteAll();
    emit(PlatoSyncInfo(platoCredential: null, syncInfo: state.syncInfo));
  }

  Future<void> updateSyncInfo() async {
    emit(PlatoSyncInfo(
        platoCredential: state.platoCredential,
        syncInfo: await SyncInfoDB.read()));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

import 'logger.dart';

// https://bloclibrary.dev/ko/getting-started/
class BlocLogger extends BlocObserver {
  final log = LoggerManager.getLogger('Bloc Observer');

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log.finest('${bloc.runtimeType} $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log.finest('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log.finest('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log.severe('$bloc, $error\n$stackTrace=======end of trace =========');
    super.onError(bloc, error, stackTrace);
  }
}

void setupBlocLogger() {
  Bloc.observer = BlocLogger();
}

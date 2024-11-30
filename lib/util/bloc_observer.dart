import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/util/logger.dart';

// https://bloclibrary.dev/ko/getting-started/
class MainBlocObserver extends BlocObserver {
  final log = LoggerManager.getLogger('Bloc Observer');
  
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log.fine('${bloc.runtimeType} $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log.fine('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log.fine('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log.severe('$bloc, $error\n$stackTrace=======end of trace =========');
    super.onError(bloc, error, stackTrace);
  }

}

void initBloc(){
  Bloc.observer = MainBlocObserver();
}

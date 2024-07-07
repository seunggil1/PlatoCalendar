import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/util/logger.dart';


class SimpleBlocObserver extends BlocObserver {
  final log = LoggerManager.getLogger('Bloc Observer');
  
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log.info('${bloc.runtimeType} $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log.info('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log.info('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log.severe('$bloc, $error\n$stackTrace=======end of trace =========');
    super.onError(bloc, error, stackTrace);
  }

}

void initBloc(){
  Bloc.observer = SimpleBlocObserver();
}

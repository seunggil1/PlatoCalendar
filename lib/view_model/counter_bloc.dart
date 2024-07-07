import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/view_model/event/bloc_event.dart';


class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) {
      emit(state + 1);
    });

    on<CounterDecrementPressed>((event, emit){
      emit(state -1);
    });
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    // print(change);
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    // print(transition);
  }
}
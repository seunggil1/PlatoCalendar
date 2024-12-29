import 'package:bloc/bloc.dart';
import 'package:plato_calendar/model/model.dart';

import './bloc_event/bloc_event.dart';
import './bloc_state/bloc_state.dart';

// TODO: implement event handler
class CalendarOptionBloc
    extends Bloc<CalendarOptionEvent, CalendarOptionState> {
  CalendarOptionBloc() : super(CalendarOptionState(CalendarOption())) {
    on<Initial>((event, emit) {});
    on<Loading>((event, emit) {});
    on<LoadingFinished>((event, emit) {});
    on<Update>((event, emit) {
      emit(CalendarOptionState(event.option));
      // CalendarOptionState test = state # CalendarOptionState;
    });
  }
}

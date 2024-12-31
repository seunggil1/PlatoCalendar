import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';

import './bloc_event/bloc_event.dart';
import './bloc_state/bloc_state.dart';

// TODO: implement event handler
class CalendarOptionBloc
    extends Bloc<CalendarOptionEvent, CalendarOptionState> {
  CalendarOptionBloc() : super(CalendarOptionState(CalendarOption())) {
    on<CalendarOptionInitial>((event, emit) {});
    on<CalendarOptionLoading>((event, emit) {});
    on<CalendarOptionLoadingFinished>((event, emit) {});
    on<CalendarOptionUpdate>((event, emit) {
      emit(CalendarOptionState(event.option));
      // CalendarOptionState test = state # CalendarOptionState;
    });
  }
}

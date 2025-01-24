import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';

import './bloc_event/bloc_event.dart';
import './bloc_state/bloc_state.dart';

// TODO: implement event handler
class SyncfusionCalendarOptionBloc
    extends Bloc<SyncfusionCalendarOptionEvent, CalendarOptionState> {
  SyncfusionCalendarOptionBloc(CalendarOption? init) : super(CalendarOptionState(init ?? CalendarOption())) {
    on<SyncfusionCalendarOptionUpdate>((event, emit) async {
      await CalendarOptionDB.write(event.option);
      emit(CalendarOptionState(event.option));
      // CalendarOptionState test = state # CalendarOptionState;
    });
  }
}

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';
import './bloc_event/bloc_event.dart';
import './bloc_state/bloc_state.dart';

class SyncfusionCalendarOptionBloc
    extends Bloc<SyncfusionCalendarOptionEvent, SyncfusionCalendarOptionState> {
  SyncfusionCalendarOptionBloc(SyncfusionCalendarOption? init)
      : super(
            SyncfusionCalendarOptionState(init ?? SyncfusionCalendarOption())) {
    on<SyncfusionCalendarOptionUpdate>((event, emit) async {
      await SyncfusionCalendarOptionDB.write(event.option);
      emit(SyncfusionCalendarOptionState(event.option,
          calendarController: state.calendarController,
          calendarView: state.calendarController.view,
          displayDate: state.calendarController.displayDate));
    });

    on<SyncfusionCalendarDisplayOptionUpdate>((event, emit) async {
      // calendarView는 DB에 기록되지 않는 정보
      emit(SyncfusionCalendarOptionState(state.calendarOption,
          calendarController: state.calendarController,
          calendarView: event.calendarView,
          displayDate:
              event.displayDatetime ?? state.calendarController.displayDate));
    });
  }
}

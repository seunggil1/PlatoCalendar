// Package imports:
import 'package:equatable/equatable.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// Project imports:
import 'package:plato_calendar/model/model.dart';

sealed class SyncfusionCalendarOptionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SyncfusionCalendarOptionUpdate extends SyncfusionCalendarOptionEvent {
  final SyncfusionCalendarOption option;

  SyncfusionCalendarOptionUpdate(this.option);

  @override
  List<Object?> get props => [option];
}

class SyncfusionCalendarDisplayOptionUpdate
    extends SyncfusionCalendarOptionEvent {
  final CalendarView calendarView;
  final DateTime? displayDatetime;

  SyncfusionCalendarDisplayOptionUpdate(
      {required this.calendarView, this.displayDatetime});

  @override
  List<Object?> get props => [calendarView, displayDatetime];
}

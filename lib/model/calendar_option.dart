import 'package:isar/isar.dart';

part 'calendar_option.g.dart';

enum SortMethod { sortByDue, sortByRegister }

enum CalendarType { split, integrated }

@collection
class CalendarOption {
  Id id = Isar.autoIncrement;

  late bool showFinished;

  @Enumerated(EnumType.name)
  late CalendarType calendarType;
}

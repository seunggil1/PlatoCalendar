import 'package:equatable/equatable.dart';
import 'package:drift/drift.dart';

import 'table/table.dart';

class TaskCheckListDisplayOption {
  int? id;

  // [지남, 6, 12, 오늘, 내일, 1주일 이하, 1주일 이상, 날짜 없음, 완료]
  // index : 0 ~ 7
  List<bool> showToDoList = [true, true, true, true, true, true, true, true];

  DateTime dbTimestamp = DateTime.now();

  TaskCheckListDisplayOption copyWith({
    int? id,
    List<bool>? showToDoList,
  }) {
    return TaskCheckListDisplayOption()
      ..showToDoList = showToDoList ?? this.showToDoList;
  }

  @override
  int get hashCode => Object.hash(showToDoList, null);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TaskCheckListDisplayOption &&
        other.showToDoList == showToDoList;
  }
}

extension TaskCheckListDisplayOptionMapper on TaskCheckListDisplayOption {
  TaskCheckListOptionTableData _toData() {
    return TaskCheckListOptionTableData(
        id: id ?? 0,
        showPassedToDoList: showToDoList[0],
        show6HoursToDoList: showToDoList[1],
        show12HoursToDoList: showToDoList[2],
        showTodayToDoList: showToDoList[3],
        showTomorrowToDoList: showToDoList[4],
        showWeekToDoList: showToDoList[5],
        showMoreThanWeekToDoList: showToDoList[6],
        showCompletedToDoList: showToDoList[7],
        dbTimestamp: dbTimestamp);
  }

  TaskCheckListOptionTableCompanion toSchema() {
    return TaskCheckListOptionTableCompanion(
        showPassedToDoList: Value(showToDoList[0]),
        show6HoursToDoList: Value(showToDoList[1]),
        show12HoursToDoList: Value(showToDoList[2]),
        showTodayToDoList: Value(showToDoList[3]),
        showTomorrowToDoList: Value(showToDoList[4]),
        showWeekToDoList: Value(showToDoList[5]),
        showMoreThanWeekToDoList: Value(showToDoList[6]),
        showCompletedToDoList: Value(showToDoList[7]),
        dbTimestamp: Value(dbTimestamp));
  }
}

extension TaskCheckListOptionTableDataMapper on TaskCheckListOptionTableData {
  TaskCheckListDisplayOption toModel() {
    return TaskCheckListDisplayOption()
      ..id = id
      ..showToDoList = [
        showPassedToDoList,
        show6HoursToDoList,
        show12HoursToDoList,
        showTodayToDoList,
        showTomorrowToDoList,
        showWeekToDoList,
        showMoreThanWeekToDoList,
        showCompletedToDoList
      ]
      ..dbTimestamp = dbTimestamp;
  }
}

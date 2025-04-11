// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:plato_calendar/etc/school_data.dart';
import 'package:plato_calendar/model/table/subject_code_color_table.dart';

class SubjectCodeColor {
  String subjectCode;
  int color;

  SubjectCodeColor({
    required this.subjectCode,
    required this.color,
  });

  @override
  int get hashCode => Object.hash(subjectCode, color);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is SubjectCodeColor && other.subjectCode == subjectCode;
  }

  @override
  String toString() {
    return 'SubjectCodeColor{subjectCode: $subjectCode, color: $color}';
  }
}

extension SubjectCodeColorMapper on SubjectCodeColor {
  SubjectCodeColorTableData _toData() {
    return SubjectCodeColorTableData(
      year: year,
      semester: semester,
      subjectCode: subjectCode,
      color: color,
    );
  }

  SubjectCodeColorTableCompanion toSchema() {
    return SubjectCodeColorTableCompanion(
      year: Value(year),
      semester: Value(semester),
      subjectCode: Value(subjectCode),
      color: Value(color),
    );
  }
}

extension SubjectCodeColorTableDataMapper on SubjectCodeColorTableData {
  SubjectCodeColor toModel() {
    return SubjectCodeColor(
      subjectCode: subjectCode,
      color: color,
    );
  }
}

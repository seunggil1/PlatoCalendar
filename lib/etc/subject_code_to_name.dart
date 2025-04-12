library;

// Project imports:
import './subject_code.dart';

const String subjectCodeAll = '전체';
const String subjectCodeNone = '과목 분류 없음';

const Map<String, String> subjectCodeToName = {
  subjectCodeAll: subjectCodeAll,
  subjectCodeNone: subjectCodeNone,
  ...subjectCode,
};

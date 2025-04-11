library;

// Project imports:
import './subject_code_2024_10.dart' as subject_code_2024_10;
import './subject_code_legacy.dart' as subject_code_legacy;

const String subjectCodeAll = '전체';
const String subjectCodeNone = '과목 분류 없음';

const Map<String, String> subjectCodeToName = {
  subjectCodeAll: subjectCodeAll,
  subjectCodeNone: subjectCodeNone,
  ...subject_code_legacy.subjectCode,
  ...subject_code_2024_10.subjectCode,
};

library;

import './subject_code_2024_10.dart' as subject_code_2024_10;
import './subject_code_legacy.dart' as subject_code_legacy;

const Map<String, String> subjectCodeToName = {
  '전체': '전체',
  ...subject_code_legacy.subjectCode,
  ...subject_code_2024_10.subjectCode,
  '과목 분류 없음': '과목 분류 없음',
};

final String subjectCodeAll = subjectCodeToName.keys.first;
final String subjectCodeNone = subjectCodeToName.keys.last;

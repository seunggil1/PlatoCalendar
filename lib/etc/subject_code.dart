library;

import './subject_code_2024_10.dart' as subject_code_2024_10;
import './subject_code_legacy.dart' as subject_code_legacy;

const Map<String, String> subjectCode = {
  ...subject_code_legacy.subjectCode,
  ...subject_code_2024_10.subjectCode,
};

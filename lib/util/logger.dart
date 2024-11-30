import 'dart:developer' as dart_logger;

import 'package:logging/logging.dart';

class LoggerManager {
  // Level.FINEST: 가장 상세한 로그
  // Level.FINER: 중간 상세 로그
  // Level.FINE: 디버그 용도로 주로 사용
  // Level.INFO: 일반적인 정보
  // Level.WARNING: 경고
  // Level.SEVERE: 치명적 오류

  static bool _init = false;

  // Logger 설정 메서드
  static void _setupLogging() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      dart_logger.log('${record.level.name}: ${record.time}: "${record.loggerName}" - "${record.message}"');
    });

    LoggerManager._init = true;
  }

  // Logger 인스턴스를 반환하는 메서드
  static Logger getLogger(String name) {
    if(!LoggerManager._init) {
      _setupLogging();
    }

    return Logger(name);
  }
}





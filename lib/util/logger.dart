import 'dart:developer' as dart_logger;

import 'package:logging/logging.dart';

class LoggerManager {
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





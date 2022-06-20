import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Logger {
  bool _init = false;
  String _uuid = "";

  String _email = "platocalendar@hotmail.com";
  String _password = "plato1234";
  SmtpServer _smtpServer;

  Logger() {
    final device = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      device.androidInfo.then((AndroidDeviceInfo info) {
        _uuid = info.androidId;
        _init = true;
      });
    } else if (Platform.isIOS) {
      device.iosInfo.then((IosDeviceInfo info) {
        _uuid = info.identifierForVendor;
        _init = true;
      });
    } else {
      throw PlatformException(code: "404", message: "Not Supported Platform");
    }
    _smtpServer = hotmail(_email, _password);
  }

  Future<bool> sendEmail(String e, String trace, String additionalInfo) async {
    if (!_init) return false;

    final message = Message()
      ..from = Address(_email, 'Plato Calendar')
      ..recipients.add('ksgg1navercom@gmail.com')
      ..subject = '[Plato Calendar Error $_uuid] ${DateTime.now()}'
      ..text = e + '\n\n' + trace + '\n\n' + additionalInfo;

    try {
      await send(message, _smtpServer);
      return true;
    } catch (e) {
      return false;
    }
  }
}

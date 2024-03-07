import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:plato_calendar/Data/appinfo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_guid/flutter_guid.dart';

import 'Data/deviceData.dart';

class Logger {
  bool _init = false;
  String _uuid = "";

  String _email = "platocalendar@hotmail.com";
  String _password = "plato1234";
  late SmtpServer _smtpServer;

  late DeviceData _deviceData;

  Logger() {
    _loggerInit();
    _smtpServer = hotmail(_email, _password);
  }

  Future<void> _loggerInit() async {
    await Future.wait([loadUUID(), loadDeviceData()]).then((value) {
      _uuid = (value[0] ?? "test") as String;
      _deviceData = value[1] as DeviceData;
    });
    _init = true;
  }

  Future<String?> loadUUID() async {
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    // guid(uuid) 생성
    if (!(await secureStorage.containsKey(key: 'guid', iOptions: options)) ||
        (await secureStorage.read(key: 'guid', iOptions: options) == null)) {
      await secureStorage.write(key: 'guid', value: Guid.newGuid.toString());
    }
    return (secureStorage.read(key: 'guid', iOptions: options));
  }

  Future<DeviceData> loadDeviceData() async {
    final device = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await device.androidInfo;
      return DeviceData.android(info);
    } else if (Platform.isIOS) {
      IosDeviceInfo info = await device.iosInfo;
      return DeviceData.ios(info);
    } else {
      throw PlatformException(code: "404", message: "Not Supported Platform");
    }
  }

  Future<bool> sendEmail(String e, String trace, String additionalInfo) async {
    if (!_init) return false;

    final message = Message()
      ..from = Address(_email, 'Plato Calendar')
      ..recipients.add('ksgg1navercom@gmail.com')
      ..subject = '[Plato Calendar Error $_uuid] ${DateTime.now()}'
      ..text = """
Device Info: ${_deviceData.brand} ${_deviceData.device} (${_deviceData.version})
Version Info: ${Appinfo.appVersion}+${Appinfo.buildversion} 
${Appinfo.buildType}


$e

$trace

$additionalInfo
""";

    try {
      await send(message, _smtpServer);
      return true;
    } catch (e) {
      return false;
    }
  }
}

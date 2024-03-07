import 'package:device_info_plus/device_info_plus.dart';

class DeviceData {
  late String brand;
  late String device;
  late String version;

  DeviceData.android(AndroidDeviceInfo info) {
    brand = info.brand;
    device = info.model;
    version = "Android ${info.version.release}";
  }

  DeviceData.ios(IosDeviceInfo info) {
    brand = "IPHONE";
    device = info.model ?? "UNKNOWN";
    version = info.systemVersion ?? "UNKNOWN";
  }
}

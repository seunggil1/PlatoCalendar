import 'package:device_info_plus/device_info_plus.dart';

class DeviceData {
  String brand;
  String device;
  String version;

  DeviceData.android(AndroidDeviceInfo info) {
    brand = info.brand ?? "UNKNOWN";
    device = info.model ?? "UNKNOWN";
    version = "Android ${info.version.release}" ?? "UNKNOWN";
  }

  DeviceData.ios(IosDeviceInfo info) {
    brand = "IPHONE";
    device = info.model ?? "UNKNOWN";
    version = info.systemVersion ?? "UNKNOWN";
  }
}

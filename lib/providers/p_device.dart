import 'package:flutter/cupertino.dart';
import 'package:ntpower/models/device.dart';
import 'package:ntpower/utils/f_device.dart';

class DeviceProvider extends ChangeNotifier {
  Device _activeDevice;

  Device getActiveDevice() {
    return _activeDevice;
  }

  void setActiveDevice(Device device) {
    _activeDevice = device;
    notifyListeners();
  }

  void clearData() {
    _activeDevice = null;
    removeDeviceId();
    notifyListeners();
  }
}

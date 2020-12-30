import 'package:flutter_blue/flutter_blue.dart';

class Bluetooth {
  void getDevices() {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    var deviceName = new List();

    // this line will start scanning bluetooth devices
    // ignore: cancel_subscriptions
    var subscription = flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        deviceName.add(r.device.name);
      }
    });

    flutterBlue.stopScan();
  }

  void connect(deviceName) async {
    await deviceName.connect();
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:beacons/beacons.dart';

import '../../models/Device.dart';
import '../../models/TargetBeacon.dart';
import '../../models/NotificationManager.dart';

class BeaconView extends StatefulWidget {
  @override
  _BeaconViewState createState() => _BeaconViewState();
}

class _BeaconViewState extends State<BeaconView> {
  final Device device = Device();
  final TargetBeacon targetBeacon =
      TargetBeacon('fda50693-a4e2-4fb1-afcf-c6eb07647825');
  final NotificationManager notificationManager = NotificationManager();
  Timer _notificationTimer;

  bool inArea = false;
  DateTime updateTime = DateTime.now();
  String message = 'no message';

  @override
  void initState() {
    super.initState();
    notificationManager.init();
    _startListen();
  }

  void _startListen() {
    targetBeacon.startMonitoring();
    targetBeacon.monitoringSubscription.onData((MonitoringResult result) {
      print(result);

      String msg = device.state();
      bool isIn = result.event == MonitoringState.enterOrInside;
      msg += isIn ? ' Enter' : ' Exit';

      setState(() {
        message = result.event.toString();
        inArea = isIn;
        notificationManager.show(msg);
      });
    });

    targetBeacon.startRanging();
    targetBeacon.rangingSubscription.onData((RangingResult result) {
      if (result.beacons.length > 0) {
        List ids = result.beacons.first.ids;
        bool matched = targetBeacon.uuid.toUpperCase() == ids[0];
        if (matched) {
          setState(() {
            device.setValue(major: ids[1], minor: ids[2]);
            updateTime = DateTime.now();
          });
        }
      }
    });
  }

  void _testNotification() {
    if (_notificationTimer != null) _notificationTimer.cancel();

    _notificationTimer = Timer(Duration(seconds: 2), () {
      print('1234');
      notificationManager.show('test notification');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test Beacon')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Beacon Info:'),
            Text('major: ${device.major}'),
            Text('minor: ${device.minor}'),
            Text('state: ${device.state()}'),
            Text('temp: ${device.temprature()}'),
            Text('battery: ${device.battery()}'),
            Text('updateTime: $updateTime'),
            Text('message: $message'),
            inArea ? Icon(Icons.link) : Icon(Icons.link_off),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _testNotification,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

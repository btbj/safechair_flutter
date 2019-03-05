import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';

import './components/head_msg.dart';
import './components/state_img_box/state_img_box.dart';
import './components/beacon_state_bar/beacon_state_bar.dart';
import './components/temperature_box/temperature_box.dart';
import './components/battery_box/battery_box.dart';

import 'package:beacons/beacons.dart';
import 'package:safe_chair/models/NotificationManager.dart';

class StateBox extends StatefulWidget {
  @override
  _StateBoxState createState() => _StateBoxState();
}

class _StateBoxState extends State<StateBox> {
  MainModel _model;

  @override
  void initState() {
    _model = ScopedModel.of(context);
    _model.chairSubject.listen((newChair) {
      if (newChair) {
        startMonitor();
      } else {
        _model.stopMonitoring();
      }
    });
    super.initState();
    startMonitor();
  }

  void startMonitor() async {
    print('start monitor');
    Beacons.backgroundMonitoringEvents()
        .listen((BackgroundMonitoringEvent event) {
      // // if (_model.currentChair == null) return;
      _model.initTargetBeacon(_model.currentChair.uuid);
      final String uuid = event.region.ids[0];
      final String type = event.type.toString();
      // final String eventString =
      //     event.state == MonitoringState.exitOrOutside
      //         ? 'Exit'
      //         : 'Inside';
      _model.checkMonitoringResult(uuid, type);
      // final NotificationManager notificationManager = NotificationManager();
      // notificationManager.init();
      // notificationManager.show(event.type.toString() + ' | ' + event.state.toString());
    });

    if (_model.currentChair == null) return;
    _model.initTargetBeacon(_model.currentChair.uuid);
    _model.startMonitoring();

    final NotificationManager notificationManager = NotificationManager();
    notificationManager.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 200,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          HeadMsg(),
          StateImgBox(),
          BeaconStateBar(),
          TemperatureBox(),
          BatteryBox(),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';

import './components/head_msg.dart';
import './components/state_img_box/state_img_box.dart';
import './components/beacon_state_bar/beacon_state_bar.dart';
import './components/temperature_box/temperature_box.dart';
import './components/battery_box/battery_box.dart';
import 'package:safe_chair/ui_elements/alert_view.dart';

import 'package:beacons/beacons.dart';
import 'package:safe_chair/models/NotificationManager.dart';

class StateBox extends StatefulWidget {
  @override
  _StateBoxState createState() => _StateBoxState();
}

class _StateBoxState extends State<StateBox> {
  MainModel _model;
  AlertView alertView = AlertView();

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

  Future showOverlay(String msg) async {
    alertView.show(context, msg);
    return;
  }

  void checkMonitoringResult(String uuid, String eventString) {
    if (_model.targetBeacon == null) return;
    bool matched = _model.targetBeacon.uuid.toUpperCase() == uuid;
    if (matched) {
      print(eventString);
      String msg = 'info: ';
      msg += eventString;
      msg += ' | $uuid';
      msg += ' | ${_model.chairState.state}';
      String time = DateTime.now().toString();
      msg += ' | $time';

      final NotificationManager notificationManager = NotificationManager();
      // notificationManager.init(onSelectNotification: showOverlay);
      notificationManager.init();
      notificationManager.show(msg, payload: time, sound: NotificationSound.beep);
      showOverlay(msg);
    }
  }

  void startMonitor() async {
    print('start monitor');
    final NotificationManager notificationManager = NotificationManager();
    notificationManager.init();

    Beacons.backgroundMonitoringEvents()
        .listen((BackgroundMonitoringEvent event) {
      if (_model.currentChair == null) return;
      _model.initTargetBeacon(_model.currentChair.uuid);
      final String uuid = event.region.ids[0];
      final String type = event.type.toString();

      checkMonitoringResult(uuid, type);
    });

    if (_model.currentChair == null) return;
    _model.initTargetBeacon(_model.currentChair.uuid);
    await _model.startMonitoring();

    _model.targetBeacon.monitoringSubscription.onData((MonitoringResult result) {
      final String uuid = result.region.ids[0];
      final String eventString = result.event.toString();
      checkMonitoringResult(uuid, eventString);
    });
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

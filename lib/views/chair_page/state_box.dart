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
import 'package:safe_chair/utils/NotificationManager.dart';

class StateBox extends StatefulWidget {
  @override
  _StateBoxState createState() => _StateBoxState();
}

class _StateBoxState extends State<StateBox> with WidgetsBindingObserver {
  MainModel _model;
  NotificationManager notificationManager;
  AlertView alertView = AlertView();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _model = ScopedModel.of(context);
    _model.chairSubject.listen((newChair) {
      if (newChair) {
        initNotificationManager();
        startMonitor();
      } else {
        _model.stopMonitoring();
      }
    });
    initNotificationManager();
    startMonitor();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future showOverlay(String msg) async {
    alertView.show(context, msg);
    return;
  }

  void checkMonitoringResult(String uuid) {
    if (_model.targetBeacon == null) return;
    bool matched = _model.targetBeacon.uuid.toUpperCase() == uuid;
    if (!matched) return;
    String msg = 'info: ';
    msg += '$uuid';
    msg += ' | ${_model.chairState.state}';
    String time = DateTime.now().toString();
    msg += ' | $time';

    _model.showAlert('exit');

    if (!_model.hasNotificationError) {
      notificationManager.show(msg, payload: time, sound: NotificationSound.beep);
    }
    showOverlay(msg);
  }

  void initNotificationManager() async {
    notificationManager = NotificationManager();
    bool noErr = await notificationManager.init();
    _model.setNotificationError(!noErr);
  }

  void startMonitor() async {
    print('start monitor');
    await _model.initCurrentChair();
    // print(_model.currentChair.uuid);

    Beacons.backgroundMonitoringEvents()
        .listen((BackgroundMonitoringEvent event) {
      if (_model.currentChair == null) return;
      _model.initTargetBeacon(_model.currentChair.uuid);
      final String uuid = event.region.ids[0];
      if (_model.currentChair.uuid.toUpperCase() != uuid) return;
      if (_model.hasNotificationError) return;
      if (event.type != BackgroundMonitoringEventType.didDetermineState) return;
      if (event.state == MonitoringState.exitOrOutside) {
        notificationManager.show('退出座椅范围，请检查座椅状态');
      } else if (event.state == MonitoringState.enterOrInside) {
        notificationManager.show('进入座椅范围，打开APP检查座椅状态');
      }
      // String msg = 'BG: ';
      // msg += _model.currentChair.uuid;
      // msg += ' | $uuid';
      // if (event.state == MonitoringState.exitOrOutside) {
      //   msg += ' | Exit';
      //   notificationManager.show(msg);
      // } else if (event.state == MonitoringState.enterOrInside) {
      //   msg += ' | Enter';
      //   notificationManager.show(msg);
      //   notificationManager.show(msg);
      // }
      // if (event.type == BackgroundMonitoringEventType.didDetermineState && event.state == MonitoringState.exitOrOutside) {
      //   _model.deactiveChairState();
      //   checkMonitoringResult(uuid);
      // }
      
    });

    if (_model.currentChair == null) return;
    _model.initTargetBeacon(_model.currentChair.uuid);
    await _model.startMonitoring();

    _model.targetBeacon.monitoringSubscription.onData((MonitoringResult result) {
      if (result.error != null) return;
      final String uuid = result.region.ids[0];
      if (_model.currentChair.uuid.toUpperCase() != uuid) return;
      String msg = 'Monitor: ';
      msg += _model.currentChair.uuid;
      msg += ' | $uuid';
      if (result.event == MonitoringState.exitOrOutside) {
        msg += ' | Exit';
        notificationManager.show(msg);
      } else if (result.event == MonitoringState.enterOrInside) {
        msg += ' | Enter';
        notificationManager.show(msg);
      }
      // if (result.event == MonitoringState.exitOrOutside) {
      //   _model.deactiveChairState();
      //   checkMonitoringResult(uuid);
      // }
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print(state);
    switch (state) {
      case AppLifecycleState.resumed:
        initNotificationManager();
        startMonitor();
        break;
      default:
    }
    super.didChangeAppLifecycleState(state);
  }
}

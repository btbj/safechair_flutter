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
        pageInitialization();
      } else {
        _model.stopMonitoring();
      }
    });
    _model.alertSubject.listen((AlertType type) {
      showOverlay(type);
    });
    pageInitialization();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future showOverlay(AlertType type) async {
    alertView.show(context, type);
    return;
  }

  void pageInitialization() async {
    await initNotificationManager();
    await startMonitor();
  }

  Future initNotificationManager() async {
    notificationManager = NotificationManager();
    bool noErr = await notificationManager.init();
    _model.setNotificationError(!noErr);
    return;
  }

  Future startMonitor() async {
    print('start monitor');
    await _model.initCurrentChair();
    await _model.initTemperatureLimit();
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
        _model.deactiveChairState();
      } else if (event.state == MonitoringState.enterOrInside) {
        notificationManager.show('进入座椅范围，打开APP检查座椅状态');
      }
    });

    if (_model.currentChair == null) return;
    _model.initTargetBeacon(_model.currentChair.uuid);
    await _model.startMonitoring();
    return;
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

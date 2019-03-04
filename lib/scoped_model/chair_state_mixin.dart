import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/models/ChairState.dart';
import 'package:beacons/beacons.dart';
import 'package:safe_chair/models/TargetBeacon.dart';
import 'package:safe_chair/models/NotificationManager.dart';

mixin ChairStateMixin on Model {
  ChairState _chairState = ChairState(0, 0);
  ChairState get chairState => _chairState;

  TargetBeacon _targetBeacon;

  void initTargetBeacon(String uuid) {
    _targetBeacon = TargetBeacon(uuid);
  }

  void startMonitoring() async {
    // if (uuid == null) return;
    if (_targetBeacon == null) return;
    await _targetBeacon.stopMonitoring();
  
    await _targetBeacon.startMonitoring();
    // _targetBeacon.monitoringSubscription.onData((MonitoringResult result) {
    //   final String uuid = result.region.ids[0];
    //   final String eventString = result.event.toString();
    //   checkMonitoringResult(uuid, eventString);
    // });

    await _targetBeacon.startRanging();
    _targetBeacon.rangingSubscription.onData((RangingResult result) {
      if (result.beacons.length > 0) {
        List ids = result.beacons.first.ids;
        bool matched = _targetBeacon.uuid.toUpperCase() == ids[0];
        if (matched) {
          _chairState.setValue(ids[1], ids[2]);
          print('${_chairState.major}, ${_chairState.minor}');
          notifyListeners();
        }
      }
    });
  }

  Future stopMonitoring() async {
    if (_targetBeacon == null) return;

    await _targetBeacon.stopMonitoring();
    _targetBeacon = null;
    return;
  }

  void checkMonitoringResult(String uuid, String eventString) {
    if (_targetBeacon == null) return;
    bool matched = _targetBeacon.uuid.toUpperCase() == uuid;
    if (matched) {
      print(eventString);
      String msg = 'info: ';
      msg += eventString;
      msg += ' | $uuid';
      msg += ' | ${_chairState.state}';

      final NotificationManager notificationManager = NotificationManager();
      notificationManager.init();
      notificationManager.show(msg);
    }
  }
}

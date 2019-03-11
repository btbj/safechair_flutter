import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/models/ChairState.dart';
import 'package:beacons/beacons.dart';
import 'package:safe_chair/utils/TargetBeacon.dart';
import 'package:rxdart/subjects.dart';

import 'package:safe_chair/store/temperatureLimitStore.dart';

mixin ChairStateMixin on Model {
  ChairState _chairState = ChairState(0, 0);
  ChairState get chairState => _chairState;

  TargetBeacon _targetBeacon;
  TargetBeacon get targetBeacon => _targetBeacon;

  PublishSubject<String> _alertSubject = PublishSubject();
  PublishSubject<String> get alertSubject => this._alertSubject;

  TemperatureLimit _temperatureLimit;
  TemperatureLimit get temperatureLimit => this._temperatureLimit;

  bool _hasBeaconError = false;
  bool get hasBeaconError => _hasBeaconError;
  bool _hasNotificationError = false;
  bool get hasNotificationError => _hasNotificationError;

  void initTargetBeacon(String uuid) {
    this._hasBeaconError = false;
    _targetBeacon = TargetBeacon(uuid);
    notifyListeners();
  }

  Future startMonitoring() async {
    // if (uuid == null) return;
    if (_targetBeacon == null) return;
    await _targetBeacon.stopMonitoring();

    await _targetBeacon.startMonitoring();

    _targetBeacon.monitoringSubscription.onData((MonitoringResult result) {
      if (result.error != null) {
        this._hasBeaconError = true;
      }
      notifyListeners();
    });

    await _targetBeacon.startRanging();
    _targetBeacon.rangingSubscription.onData((RangingResult result) {
      if (result.error != null) {
        this._hasBeaconError = true;
        notifyListeners();
        return;
      }
      if (result.beacons == null) return;
      if (result.beacons.length > 0) {
        List ids = result.beacons.first.ids;
        bool matched = _targetBeacon.uuid.toUpperCase() == ids[0];
        if (matched) {
          _chairState.setValue(ids[1], ids[2]);
          // print('${_chairState.major}, ${_chairState.minor}');
          notifyListeners();
        }
      }
    });
    return;
  }

  Future stopMonitoring() async {
    if (_targetBeacon == null) return;

    await _targetBeacon.stopMonitoring();
    _targetBeacon = null;
    return;
  }

  void showAlert(String alertmsg) {
    _alertSubject.add(alertmsg);
  }

  void setNotificationError(bool value) {
    _hasNotificationError = value;
    notifyListeners();
  }

  void deactiveChairState() {
    _chairState.deactive();
    notifyListeners();
  }

  Future initTemperatureLimit() async {
    print('init temperature limit');
    this._temperatureLimit = await TemperatureLimitStore.getLimit();
    notifyListeners();
    return;
  }

  Future setTemperatureLimit(TemperatureLimit limit) async {
    print('set temperature limit');
    await TemperatureLimitStore.saveLimit(limit);
    this._temperatureLimit = limit;
    notifyListeners();
    return;
  }
}

import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/models/ChairState.dart';
import 'package:beacons/beacons.dart';
import 'package:safe_chair/utils/TargetBeacon.dart';
import 'package:rxdart/subjects.dart';

import 'package:safe_chair/store/temperatureLimitStore.dart';
import 'package:safe_chair/utils/NotificationManager.dart';

mixin ChairStateMixin on Model {
  ChairState _chairState = ChairState(0, 0);
  ChairState get chairState => _chairState;

  TargetBeacon _targetBeacon;
  TargetBeacon get targetBeacon => _targetBeacon;

  PublishSubject<String> _alertSubject = PublishSubject();
  PublishSubject<String> get alertSubject => this._alertSubject;

  TemperatureLimit _temperatureLimit;
  TemperatureLimit get temperatureLimit => this._temperatureLimit;

  Timer _errorTimer;
  bool _hasPushedStateError = false;
  bool _hasPushedTempError = false;
  bool _hasPushedBatteryError = false;

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
        notifyListeners();
        return;
      }
      final String uuid = result.region.ids[0];
      if (_targetBeacon.uuid.toUpperCase() != uuid) return;
      // String msg = 'Monitor: ';
      // msg += _targetBeacon.uuid;
      // msg += ' | $uuid';
      // if (result.event == MonitoringState.exitOrOutside) {
      //   msg += ' | Exit';
      // } else if (result.event == MonitoringState.enterOrInside) {
      //   msg += ' | Enter';
      // }
      // this.pushNotification(msg);
      if (result.event ==MonitoringState.exitOrOutside && this._chairState.pad) {
        String msg = '您已经离开安全座椅，宝宝还在座位上， 请确认儿童是否离座！';
        this.pushNotification(msg);
        this.showAlert(msg);
      }

      if (result.event ==MonitoringState.exitOrOutside) {
        this.deactiveChairState();
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
        String uuid = ids[0];
        int major = ids[1];
        int minor = ids[2];
        bool matched = _targetBeacon.uuid.toUpperCase() == uuid;
        if (!matched) return;
        if (_chairState.major == major && _chairState.minor == minor) return;
        _chairState.setValue(ids[1], ids[2]);
        checkChairState();
        notifyListeners();
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

  void pushNotification(String msg) async {
    NotificationManager nm = NotificationManager();
    bool noErr = await nm.init();
    if (noErr) {
      nm.show(msg, sound: NotificationSound.beep);
    }
  }

  void checkChairState() {
    if (this._errorTimer != null) this._errorTimer.cancel();
    if (this._chairState.state != '111111' && !this._hasPushedStateError) {
      this._errorTimer = Timer(Duration(seconds: 10), () async {
        this._hasPushedStateError = true;
        String msg = '座椅安装不到位，请检查所有安装项！';
        this.pushNotification(msg);
        this.showAlert(msg);
      });
    }
    if (this._chairState.state == '111111') {
      this._hasPushedStateError = false;
    }

    if (this._chairState.battery < 10 && !this._hasPushedBatteryError) {
      this._hasPushedBatteryError = true;
      String msg = '座椅电量过低，请更换座椅电池！';
      this.pushNotification(msg);
      this.showAlert(msg);
    }

    if (this.temperatureLimit != null) {
      if (this.temperatureLimit.highSwitch &&
          this.temperatureLimit.high < this._chairState.temprature &&
          !this._hasPushedTempError) {
        this._hasPushedTempError = true;
        String msg = '座椅温度过高，请确认车内环境！';
        this.pushNotification(msg);
        this.showAlert(msg);
      } // 高温报警

      if (this.temperatureLimit.lowSwitch &&
          this.temperatureLimit.low > this._chairState.temprature &&
          !this._hasPushedTempError) {
        this._hasPushedTempError = true;
        String msg = '座椅温度过低，请确认车内环境！';
        this.pushNotification(msg);
        this.showAlert(msg);
      } // 低温报警

      if (this.temperatureLimit.low < this._chairState.temprature &&
          this.temperatureLimit.high > this._chairState.temprature &&
          this._hasPushedTempError) {
        this._hasPushedTempError = false;
      } // 温度正常后重置警报
    }
  }
}

import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/models/ChairState.dart';
import 'package:beacons/beacons.dart';
import 'package:safe_chair/models/TargetBeacon.dart';
import 'package:safe_chair/models/NotificationManager.dart';

mixin ChairStateMixin on Model {
  ChairState _chairState = ChairState(0, 0);
  ChairState get chairState => _chairState;

  TargetBeacon _targetBeacon;

  void startMonitoring(String uuid) async {
    if (_targetBeacon != null) await _targetBeacon.startMonitoring();
    if (uuid == null) return;

    _targetBeacon = TargetBeacon(uuid);

    await _targetBeacon.startMonitoring();
    _targetBeacon.monitoringSubscription.onData((MonitoringResult result) {
      final String uuid = result.region.ids[0];
      final String eventString = result.event.toString();
      checkMonitoringResult(uuid, eventString);
    });

    await _targetBeacon.startRanging();
    _targetBeacon.rangingSubscription.onData((RangingResult result) {
      if (result.beacons.length > 0) {
        List ids = result.beacons.first.ids;
        bool matched = _targetBeacon.uuid.toUpperCase() == ids[0];
        if (matched) {
          _chairState = ChairState(ids[1], ids[2]);
          print('${_chairState.major}, ${_chairState.minor}');
          notifyListeners();
        }
      }
    });
  }

  void checkMonitoringResult(String uuid, String eventString) {
    bool matched = _targetBeacon.uuid.toUpperCase() == uuid;
    if (matched) {
      print(eventString);
      String msg = 'info: ';
      msg += eventString;
      msg += ' | $uuid';

      final NotificationManager notificationManager = NotificationManager();
      notificationManager.init();
      notificationManager.show(msg);
    }
  }
}

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
    if (uuid == null) return;

    _targetBeacon = TargetBeacon(uuid);

    await _targetBeacon.startMonitoring();
    _targetBeacon.monitoringSubscription.onData((MonitoringResult result) {
      print(result);
      print(result.region.ids);
      bool matched = _targetBeacon.uuid.toUpperCase() == result.region.ids[0];
      if (matched) {
        print(result.event.toString());
        final NotificationManager notificationManager = NotificationManager();
        notificationManager.init();
        notificationManager.show(result.event.toString());
      }
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
}

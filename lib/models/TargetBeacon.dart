import 'package:beacons/beacons.dart';
import 'dart:async';

class TargetBeacon {
  String uuid;
  StreamSubscription<RangingResult> rangingSubscription;
  StreamSubscription<MonitoringResult> monitoringSubscription;

  TargetBeacon(this.uuid);

  void startRanging() {
    if (rangingSubscription != null) rangingSubscription.cancel();

    rangingSubscription = Beacons.ranging(
      region: BeaconRegionIBeacon(identifier: '', proximityUUID: uuid),
      inBackground: true,
    ).listen((_) {});
  }

  void startMonitoring() {
    if (monitoringSubscription != null) monitoringSubscription.cancel();
    monitoringSubscription = Beacons.monitoring(
      region: BeaconRegionIBeacon(identifier: '', proximityUUID: uuid),
      inBackground: true,
    ).listen((_) {});
  }
}

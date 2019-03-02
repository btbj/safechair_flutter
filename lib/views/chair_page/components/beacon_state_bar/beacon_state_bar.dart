import 'package:flutter/material.dart';
import './components/ble_box.dart';
import './components/baby_box.dart';
import './components/protect_box.dart';

class BeaconStateBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          BleBox(),
          ProtectBox(),
          BabyBox(),
        ],
      ),
    );
  }
}
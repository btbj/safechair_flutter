import 'package:flutter/material.dart';
import './components/battery_icon.dart';
import './components/battery_text.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';

class BatteryBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      final bool active = model.chairState.active;
      final int progress = model.chairState.battery;
      return Container(
        alignment: Alignment.center,
        height: 80,
        width: 150,
        decoration: BoxDecoration(
          // color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            BatteryIcon(active: active, progress: progress),
            SizedBox(height: 5),
            BatteryText(active: active, progress: progress),
          ],
        ),
      );
    });
  }
}

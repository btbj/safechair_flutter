import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/store/temperatureLimitStore.dart';

class TemperatureSwitch extends StatelessWidget {
  final bool isHigh;
  TemperatureSwitch({this.isHigh});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      TemperatureLimit limit = model.temperatureLimit;
      return Switch(
        value: isHigh ? limit.highSwitch : limit.lowSwitch,
        onChanged: (value) async {
          await model.setTemperatureLimit(TemperatureLimit(
            high: limit.high,
            low: limit.low,
            highSwitch: isHigh ? value : limit.highSwitch,
            lowSwitch: !isHigh ? value : limit.lowSwitch,
            isF: limit.isF,
          ));
        },
        activeColor: primaryColor,
        inactiveTrackColor: Colors.grey[700],
        inactiveThumbColor: Colors.grey[400],
      );
    });
  }
}

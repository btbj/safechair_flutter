import 'package:flutter/material.dart';

class TemperatureTextBox extends StatelessWidget {
  final int temperature;
  TemperatureTextBox(this.temperature);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Baseline(
              baseline: 30,
              baselineType: TextBaseline.alphabetic,
              child: Text(temperature == null ? '??' : temperature.toString(),
                  style: TextStyle(
                      fontSize: 40,
                      color: temperature == null ? Colors.grey : Colors.white,
                      textBaseline: TextBaseline.alphabetic)),
            ),
            Baseline(
              baseline: 25,
              baselineType: TextBaseline.alphabetic,
              child: Text('℃',
                  style: TextStyle(
                      fontSize: 20,
                      color: temperature == null ? Colors.grey : Colors.white,
                      textBaseline: TextBaseline.alphabetic)),
            ),
          ],
        ),
        Text(
          '当前车内温度',
          style: TextStyle(fontSize: 13, color: temperature == null ? Colors.grey : Colors.white),
        ),
      ],
    );
  }
}

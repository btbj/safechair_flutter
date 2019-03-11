import 'package:flutter/material.dart';

class TemperatureTextBox extends StatelessWidget {
  final int temperature;
  final bool isF;
  TemperatureTextBox(this.temperature, this.isF);

  @override
  Widget build(BuildContext context) {
    String temperatureNumberText = '??';
    if (temperature != null) {
      if (!isF) {
        temperatureNumberText = temperature.toString();
      } else {
        final int fTemp = (temperature * 1.8).round() + 32;
        temperatureNumberText = fTemp.toString();
      }
    }
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
              child: Text(
                temperatureNumberText,
                style: TextStyle(
                  fontSize: 40,
                  color: temperature == null ? Colors.grey : Colors.white,
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
            ),
            Baseline(
              baseline: 25,
              baselineType: TextBaseline.alphabetic,
              child: Text(!isF ? '℃' : '℉',
                  style: TextStyle(
                      fontSize: 20,
                      color: temperature == null ? Colors.grey : Colors.white,
                      textBaseline: TextBaseline.alphabetic)),
            ),
          ],
        ),
        Text(
          '当前车内温度',
          style: TextStyle(
              fontSize: 13,
              color: temperature == null ? Colors.grey : Colors.white),
        ),
      ],
    );
  }
}

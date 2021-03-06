import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/store/temperatureLimitStore.dart';
import './slider_dialog.dart';
import './temperature_switch.dart';
import 'package:safe_chair/lang/custom_localization.dart';

class TemperatureLine extends StatelessWidget {
  final bool isHigh;
  TemperatureLine({this.isHigh});

  String _generateTempString(TemperatureLimit limit) {
    int cTemp = isHigh ? limit.high : limit.low;
    if (!limit.isF) {
      return '$cTemp' + '℃';
    } else {
      final int fTemp = (cTemp * 1.8).round() + 32;
      return '$fTemp' + '℉';
    }
  }

  void showTempDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SliderDialog(isHigh: isHigh);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      final Color primaryColor = Theme.of(context).primaryColor;
      String listTitle = isHigh
          ? CustomLocalizations.of(context)
              .system('high_temperature_alert_label')
          : CustomLocalizations.of(context)
              .system('low_temperature_alert_label');

      return ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 150,
              child: Text(listTitle,
                  style: TextStyle(color: primaryColor), softWrap: true),
            ),
            FlatButton(
              child: Text(_generateTempString(model.temperatureLimit),
                  style: TextStyle(color: primaryColor)),
              onPressed: () {
                showTempDialog(context);
              },
            ),
            // LowTempString(isF: isF)
          ],
        ),
        trailing: TemperatureSwitch(isHigh: isHigh),
      );
    });
  }
}

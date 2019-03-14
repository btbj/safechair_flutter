import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/store/temperatureLimitStore.dart';

class UnitSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      final Color activeColor = Theme.of(context).primaryColor;
      final Color inactiveColor = Colors.grey[700];

      return GestureDetector(
        onTap: () {
          model.setTemperatureLimit(TemperatureLimit(
            high: model.temperatureLimit.high,
            low: model.temperatureLimit.low,
            highSwitch: model.temperatureLimit.highSwitch,
            lowSwitch: model.temperatureLimit.lowSwitch,
            isF: !model.temperatureLimit.isF
          ));
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: model.temperatureLimit.isF ? inactiveColor : activeColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    '℃',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: !model.temperatureLimit.isF ? inactiveColor : activeColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    '℉',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

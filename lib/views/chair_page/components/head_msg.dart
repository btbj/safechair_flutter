import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/lang/custom_localization.dart';

class HeadMsg extends StatelessWidget {
  Widget _buildIcon(bool active, bool hasError) {
    if (!hasError) {
      return ClipOval(
        child: Container(
          alignment: Alignment.center,
          height: 15,
          width: 15,
          color: Colors.blue,
          child: Icon(Icons.favorite, color: Colors.white, size: 10),
        ),
      );
    } else {
      return ClipOval(
        child: Container(
          alignment: Alignment.center,
          height: 15,
          width: 15,
          color: active ? Colors.red : Colors.grey,
          child: Text(
            '!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      );
    }
  }

  Widget _buildText(String message, bool active, bool hasError) {
    Color textColor = Colors.white;
    if (hasError) textColor = Colors.red;
    if (!active) textColor = Colors.grey;
    return Text(
      message,
      style: TextStyle(color: textColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      String errMsg;
      bool active = model.chairState.active;
      bool hasError = true;

      if (model.chairState.battery < 10) errMsg = CustomLocalizations.of(context).message('error_low_battery');
      if (model.temperatureLimit != null) {
        if (model.temperatureLimit.highSwitch &&
            model.temperatureLimit.high < model.chairState.temprature) {
          errMsg = CustomLocalizations.of(context).message('error_high_temp');
        }
        if (model.temperatureLimit.lowSwitch &&
            model.temperatureLimit.low > model.chairState.temprature) {
          errMsg = CustomLocalizations.of(context).message('error_low_temp');
        }
      }
      if (!model.chairState.buckle) errMsg = CustomLocalizations.of(context).message('error_buckle');
      if (!model.chairState.lfix) errMsg = CustomLocalizations.of(context).message('error_lfix');
      if (!model.chairState.rfix) errMsg = CustomLocalizations.of(context).message('error_rfix');
      if (!model.chairState.routation) errMsg = CustomLocalizations.of(context).message('error_routation');
      if (!model.chairState.pad) errMsg = CustomLocalizations.of(context).message('error_pad');
      if (!model.chairState.leg) errMsg = CustomLocalizations.of(context).message('error_leg');
      if (!active) errMsg = CustomLocalizations.of(context).message('error_no_signal');
      if (errMsg == null) {
        hasError = false;
        errMsg = CustomLocalizations.of(context).message('error_none');
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildIcon(active, hasError),
          SizedBox(width: 5),
          _buildText(errMsg, active, hasError),
        ],
      );
    });
  }
}

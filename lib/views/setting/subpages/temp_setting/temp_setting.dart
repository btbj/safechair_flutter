import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';
import './components/unit_line.dart';
import './components/temp_line.dart';
import 'package:safe_chair/lang/custom_localization.dart';

class TempSettingPage extends StatelessWidget {
  Widget _buildInfoBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          TemperatureLine(isHigh: true),
          TemperatureLine(isHigh: false),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(color: Colors.grey),
          ),
          UnitLine(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasicPlate(
      title: CustomLocalizations.of(context).system('temperature_setting_title'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20),
          _buildInfoBox(),
        ],
      ),
    );
  }
}

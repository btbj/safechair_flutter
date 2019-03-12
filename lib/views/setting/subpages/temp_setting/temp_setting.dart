import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';
import './components/unit_line.dart';
import './components/temp_line.dart';

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
      title: '温度设置',
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

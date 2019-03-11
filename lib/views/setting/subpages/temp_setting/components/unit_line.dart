import 'package:flutter/material.dart';
import './unit_switch.dart';

class UnitLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return ListTile(
      title: Text('温度单位', style: TextStyle(color: primaryColor)),
      trailing: UnitSwitch(),
    );
  }
}
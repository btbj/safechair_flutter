import 'package:flutter/material.dart';
import './unit_switch.dart';
import 'package:safe_chair/lang/custom_localization.dart';

class UnitLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return ListTile(
      title: Text(
          CustomLocalizations.of(context).system('temperature_unit_label'),
          style: TextStyle(color: primaryColor)),
      trailing: UnitSwitch(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';

import 'package:safe_chair/lang/custom_localization.dart';

class ServicePolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return BasicPlate(
      title: CustomLocalizations.of(context).system('policy_title'),
      child: Center(
        child: Text(
          'service policy',
          style: TextStyle(color: primaryColor),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';

class ServicePolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return BasicPlate(
      title: '服务协议',
      child: Center(
        child: Text(
          'service policy',
          style: TextStyle(color: primaryColor),
        ),
      ),
    );
  }
}

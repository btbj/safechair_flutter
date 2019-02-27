import 'package:flutter/material.dart';

class LogoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/img/logo/logo.png',
        width: 120,
      ),
    );
  }
}

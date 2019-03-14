import 'package:flutter/material.dart';
import 'dart:async';

class NavManager {
  static Future push(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void logout(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
  }
}

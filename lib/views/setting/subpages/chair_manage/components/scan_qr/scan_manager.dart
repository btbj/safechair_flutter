import 'dart:async';
import 'package:flutter/material.dart';
import './reader_page.dart';

class ScanManager {
  static Future start(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReaderPage(),
      ),
    );
  }
}

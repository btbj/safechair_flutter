import 'package:flutter/material.dart';

class WebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'web page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

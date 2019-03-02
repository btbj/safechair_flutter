import 'package:flutter/material.dart';

class CenterImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.grey,
      height: 250,
      width: 180,
      child: Text('center img'),
    );
  }
}
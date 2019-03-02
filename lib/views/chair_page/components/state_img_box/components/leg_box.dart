import 'package:flutter/material.dart';

class LegBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue
      ),
      child: Text('Leg', style: TextStyle(fontSize: 10)),
    );
  }
}
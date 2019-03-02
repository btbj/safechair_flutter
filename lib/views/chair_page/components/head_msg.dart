import 'package:flutter/material.dart';

class HeadMsg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.favorite, color: Colors.white, size: 15),
        SizedBox(width: 5),
        Text('无异常', style: TextStyle(color: Colors.white)),
      ],
    );
  }
}

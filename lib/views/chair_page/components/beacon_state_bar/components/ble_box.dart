import 'package:flutter/material.dart';

class BleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.bluetooth, color: Colors.white, size: 14),
          Text('蓝牙', style: TextStyle(color: Colors.white)),
          SizedBox(width: 5),
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}
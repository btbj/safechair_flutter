import 'package:flutter/material.dart';

class BabyBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text('宝宝入座', style: TextStyle(color: Colors.white)),
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
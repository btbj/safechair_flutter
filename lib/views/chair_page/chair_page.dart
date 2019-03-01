import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/head_bar.dart';

class ChairPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            HeadBar(title: '我的座椅'),
            Text('chair info', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

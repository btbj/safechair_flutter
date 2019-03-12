import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/head_bar.dart';
import './state_box.dart';

class ChairPage extends StatelessWidget {
  Widget buildListViewBox() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          StateBox(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            HeadBar(title: '我的座椅'),
            buildListViewBox(),
          ],
        ),
      ),
    );
  }
}

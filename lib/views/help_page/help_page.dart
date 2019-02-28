import 'package:flutter/material.dart';
import './components/logout_btn.dart';
import 'package:safe_chair/ui_elements/head_bar.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            HeadBar(title: '帮助'),
            LogoutBtn(),
          ],
        ),
      ),
    );
  }
}

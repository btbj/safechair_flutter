import 'package:flutter/material.dart';
import './components/logout_btn.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('help page'),
            LogoutBtn(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BasicPlate extends StatelessWidget {
  final Widget child;

  BasicPlate({this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor, //change your color here
          ),
        ),
        backgroundColor: Colors.black,
        body: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 100,
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
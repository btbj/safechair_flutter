import 'package:flutter/material.dart';

class BasicPlate extends StatelessWidget {
  final Widget child;
  final String title;

  BasicPlate({this.title = '', this.child});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            title,
            style: TextStyle(color: primaryColor),
          ),
          iconTheme: IconThemeData(color: primaryColor),
        ),
        backgroundColor: Colors.black,
        body: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 150,
              child: child,
            )
          ],
        ),
      ),
    );
  }
}

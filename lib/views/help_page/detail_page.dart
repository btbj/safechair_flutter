import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String content;

  DetailPage({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return BasicPlate(
      title: title,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          content,
          style: TextStyle(color: primaryColor, fontSize: 17),
        ),
      ),
    );
  }
}

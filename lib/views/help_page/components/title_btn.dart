import 'package:flutter/material.dart';
import '../detail_page.dart';
import 'package:safe_chair/utils/nav_manager.dart';

class TitleBtn extends StatelessWidget {
  final String title;
  final String content;
  TitleBtn({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return ListTile(
      title: Text(title, style: TextStyle(color: primaryColor)),
      onTap: () {
        NavManager.push(context, DetailPage(title: title, content: content));
      },
    );
  }
}

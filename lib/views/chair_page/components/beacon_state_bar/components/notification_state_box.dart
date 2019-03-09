import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';

class NotificationStateBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      final bool hasError = model.hasNotificationError;
      return Container(
        height: 50,
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.notifications, color: Colors.white, size: 14),
            Text('推送通知', style: TextStyle(color: Colors.white)),
            SizedBox(width: 5),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: hasError ? Colors.red : Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      );
    });
  }
}

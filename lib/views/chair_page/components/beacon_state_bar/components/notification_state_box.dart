import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/lang/custom_localization.dart';

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
            Text(
              CustomLocalizations.of(context).system('notification_state_text'),
              style: TextStyle(color: Colors.white, fontSize: model.isEN ? 10 : 14),
            ),
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

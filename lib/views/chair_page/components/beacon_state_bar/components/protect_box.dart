import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';

class ProtectBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      final bool haveChair = model.currentChair != null;

      // final Color displayColor = haveChair ? Colors.blue : Colors.grey;
      final Color displayColor = Colors.grey;
      final String displayText = haveChair ? '已设置' : '未设置';

      return Container(
        height: 60,
        width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: displayColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          height: 56,
          width: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: displayColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              displayText,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      );
    });
  }
}

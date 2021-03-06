import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/lang/custom_localization.dart';

class ProtectBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      final bool haveChair = model.currentChair != null;

      final Color displayColor =
          model.chairState.active ? Colors.blue : Colors.grey;
      String displayText = haveChair
          ? CustomLocalizations.of(context).system('beacon_set_text')
          : CustomLocalizations.of(context).system('beacon_notset_text');
      if (model.chairState.active)
        displayText =
            CustomLocalizations.of(context).system('beacon_protecting_text');

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
              style: TextStyle(fontSize: model.isEN ? 9 : 12),
            ),
          ),
        ),
      );
    });
  }
}

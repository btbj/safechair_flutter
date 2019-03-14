import 'package:flutter/material.dart';
import 'package:safe_chair/lang/custom_localization.dart';

class BatteryText extends StatelessWidget {
  final int progress;
  final bool active;
  BatteryText({this.active, this.progress});

  @override
  Widget build(BuildContext context) {
    Color getTextColor() {
      if (!active) return Colors.grey;
      if (progress <= 10)
        return Colors.red;
      else if (progress <= 20)
        return Colors.orange;
      else
        return Colors.white;
    }

    TextStyle textStyle = TextStyle(fontSize: 12, color: getTextColor());

    String progressText = active ? '$progress' : '??';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          CustomLocalizations.of(context).system('battery_level'),
          style: textStyle,
        ),
        Text('$progressText' + '%', style: textStyle),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';

class RFixBox extends StatelessWidget {
  Color _getBlendColor({bool active, bool err}) {
    if (active) {
      if (err) {
        return Colors.red;
      } else {
        return Colors.blue;
      }
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return ClipOval(
        child: SizedBox(
          height: 40,
          width: 40,
          child: Image(
            image: AssetImage('assets/img/state_icon/icon3.png'),
            color: _getBlendColor(
                active: model.chairState.active, err: !model.chairState.rfix),
            colorBlendMode: BlendMode.color,
            fit: BoxFit.cover,
          ),
        ),
      );
    });
  }
}

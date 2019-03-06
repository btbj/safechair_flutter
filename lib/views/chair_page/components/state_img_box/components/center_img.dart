import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';

class CenterImg extends StatelessWidget {
  Widget _buildImageBox(MainModel model) {
    final bool active = model.chairState.active;
    return Image(
      height: 230,
      image: AssetImage('assets/img/chair_img/chair.png'),
      color: !active ? Colors.black : null,
      colorBlendMode: BlendMode.color,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return Container(
        alignment: Alignment.center,
        height: 250,
        width: 180,
        // child: Text(model.chairState.state),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildImageBox(model),
            Text(model.chairState.state, style: TextStyle(color: Colors.white)),
          ],
        ),
      );
    });
  }
}

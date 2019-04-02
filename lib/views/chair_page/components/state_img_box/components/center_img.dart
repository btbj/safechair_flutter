import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';

class CenterImg extends StatelessWidget {
  Widget _buildImageBox(MainModel model) {
    final bool active = model.chairState.active;
    final Color blendColor = !active ? Colors.black : null;
    AssetImage image = AssetImage('assets/img/chair_img/chair.png');
    if (active) {
      if (!model.chairState.buckle) {
        image = AssetImage('assets/img/chair_img/chair-err1.png');
      } else if (!model.chairState.lfix) {
        image = AssetImage('assets/img/chair_img/chair-err2.png');
      } else if (!model.chairState.rfix) {
        image = AssetImage('assets/img/chair_img/chair-err3.png');
      } else if (!model.chairState.routation) {
        image = AssetImage('assets/img/chair_img/chair-err4.png');
      } else if (!model.chairState.pad) {
        image = AssetImage('assets/img/chair_img/chair-err5.png');
      } else if (!model.chairState.leg) {
        image = AssetImage('assets/img/chair_img/chair-err6.png');
      }
    }

    return Image(
      height: 220,
      image: image,
      color: blendColor,
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
        child: _buildImageBox(model),
        // child: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: <Widget>[
        //     _buildImageBox(model),
        //     Text(model.chairState.state, style: TextStyle(color: Colors.white)),
        //   ],
        // ),
      );
    });
  }
}

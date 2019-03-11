import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';

class HeadMsg extends StatelessWidget {
  Widget _buildIcon(String errMsg) {
    if (errMsg == null) {
      return ClipOval(
        child: Container(
          alignment: Alignment.center,
          height: 15,
          width: 15,
          color: Colors.blue,
          child: Icon(Icons.favorite, color: Colors.white, size: 10),
        ),
      );
    } else {
      return ClipOval(
        child: Container(
          alignment: Alignment.center,
          height: 15,
          width: 15,
          color: errMsg == '无座椅信号' ? Colors.grey : Colors.red,
          child: Text(
            '!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      );
    }
  }

  Widget _buildText(String errMsg) {
    if (errMsg == null) {
      return Text('无异常', style: TextStyle(color: Colors.white));
    } else if (errMsg == '无座椅信号') {
      return Text(errMsg, style: TextStyle(color: Colors.grey));
    } else {
      return Text(errMsg, style: TextStyle(color: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      String errMsg;
      if (model.chairState.battery < 10) errMsg = '座椅电量过低';
      if (model.temperatureLimit != null) {
        if (model.temperatureLimit.highSwitch &&
            model.temperatureLimit.high < model.chairState.temprature) {
          errMsg = '座椅温度过高';
        }
        if (model.temperatureLimit.lowSwitch &&
            model.temperatureLimit.low > model.chairState.temprature) {
          errMsg = '座椅温度过低';
        }
      }
      if (!model.chairState.buckle) errMsg = '五点式卡扣异常';
      if (!model.chairState.lfix) errMsg = '左ISOFIX接口异常';
      if (!model.chairState.rfix) errMsg = '右ISOFIX接口异常';
      if (!model.chairState.routation) errMsg = '旋转卡扣异常';
      if (!model.chairState.pad) errMsg = '座椅坐垫异常';
      if (!model.chairState.leg) errMsg = '支撑腿异常';
      if (!model.chairState.active) errMsg = '无座椅信号';

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildIcon(errMsg),
          SizedBox(width: 5),
          _buildText(errMsg),
        ],
      );
    });
  }
}

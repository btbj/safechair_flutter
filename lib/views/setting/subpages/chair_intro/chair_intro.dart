import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';
import 'package:safe_chair/ui_elements/basic_btn.dart';

class ChairIntroPage extends StatefulWidget {
  @override
  _ChairIntroPageState createState() => _ChairIntroPageState();
}

class _ChairIntroPageState extends State<ChairIntroPage> {
  @override
  void initState() {
    _getDeviceInfo();
    super.initState();
  }

  void _getDeviceInfo() {
    print('get device info');
  }

  Widget _buildVideoBtn() {
    return BasicBtn(
      label: '安装视频',
      onTap: () {
        print('check video');
      },
    );
  }

  Widget _buildLine(String title, String info) {
    final TextStyle textStyle = TextStyle(color: Colors.grey);
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title, style: textStyle),
          Text(info, style: textStyle),
        ],
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          _buildLine('座椅名称:', '茧之爱'),
          _buildLine('座椅型号:', '茧之爱'),
          _buildLine('适用范围:', '茧之爱'),
          _buildLine('安装方式:', '茧之爱'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasicPlate(
      title: '座椅说明',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20),
          _buildInfoBox(),
          SizedBox(height: 20),
          _buildVideoBtn(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';
import 'package:safe_chair/ui_elements/basic_btn.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/services/api.dart' as api;
import 'package:safe_chair/ui_elements/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ChairIntroPage extends StatefulWidget {
  @override
  _ChairIntroPageState createState() => _ChairIntroPageState();
}

class _ChairIntroPageState extends State<ChairIntroPage> {
  MainModel _model;
  Map<String, String> chairInfo = {
    'name': '',
    'model': '',
    'useful_area': '',
    'setup_type': '',
    'setup_video_url': null
  };

  @override
  void initState() {
    _model = ScopedModel.of(context);
    _getDeviceInfo();
    super.initState();
  }

  void _getDeviceInfo() async {
    print('get device info');
    if (_model.currentChair == null) return;
    try {
      final Map<String, dynamic> response =
          await api.post(context, api: '/device/get_info_by_uuid', body: {
        'token': _model.authUser.token,
        'uuid': _model.currentChair.uuid,
      });
      print('r: $response');
      if (response['data']['product'] == null) {
        Toast.show(context, '未找到产品');
        return;
      }
      chairInfo['name'] = response['data']['product']['name'];
      chairInfo['model'] = response['data']['product']['model'];
      chairInfo['useful_area'] = response['data']['product']['useful_area'];
      chairInfo['setup_type'] = response['data']['product']['setup_type'];
      chairInfo['setup_video_url'] =
          response['data']['product']['setup_video_url'];
      setState(() {});
      Toast.show(context, '获取成功');
    } catch (e) {
      print(e);
      Toast.show(context, e);
    }
  }

  Widget _buildVideoBtn() {
    Function onTap;
    final String url = chairInfo['setup_video_url'];
    if (url != null) {
      onTap = () async {
        print('check video: ' + chairInfo['setup_video_url']);
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          Toast.show(context, '不能打开网址');
        }
      };
    }
    return BasicBtn(
      label: '安装视频',
      onTap: onTap,
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
          _buildLine('座椅名称:', chairInfo['name']),
          _buildLine('座椅型号:', chairInfo['model']),
          _buildLine('适用范围:', chairInfo['useful_area']),
          _buildLine('安装方式:', chairInfo['setup_type']),
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

import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';
import './components/menu_nav.dart';
import './components/logout_btn.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';

class SettingPage extends StatefulWidget {
  @override
  SettingPageState createState() {
    return new SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
  String deviceName = '茧之爱2';
  String usernameString = 'aaa@aaa.aaa';
  String versionCode = '0.1.3';
  MainModel _model;

  @override
  void initState() {
    _model = ScopedModel.of(context);
    usernameString = _model.authUser.username;
    super.initState();
  }

  Widget _buildChairManageBtn() {
    final String label = '座椅管理';
    return MenuNav(
      label: label,
      endLabel: deviceName,
      onTap: () {
        print('nav to chair manage');
      },
    );
  }

  Widget _buildChairIntroBtn() {
    final String label = '座椅说明';
    return MenuNav(
      label: label,
      endLabel: deviceName,
      onTap: () {
        print('nav to chair intro');
      },
    );
  }

  Widget _buildTempBtn() {
    final String label = '温度控制';
    return MenuNav(
      label: label,
      onTap: () {
        print('nav to temp control');
      },
    );
  }

  Widget _buildPassBtn() {
    final String label = '密码设置';
    return MenuNav(
      label: label,
      onTap: () {
        print('nav to pass setting');
      },
    );
  }

  Widget _buildListBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildChairManageBtn(),
          _buildChairIntroBtn(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(color: Colors.grey),
          ),
          _buildTempBtn(),
          _buildPassBtn(),
        ],
      ),
    );
  }

  Widget _buildInfoMessage() {
    final TextStyle style =TextStyle(color: Colors.grey[700], fontSize: 12);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('使用' + usernameString + '登录', style: style),
        Text('版本号' + versionCode, style: style),
        Text('隐私政策', style: style),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasicPlate(
      title: '设置',
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          _buildListBox(),
          SizedBox(height: 10),
          LogoutBtn(),
          SizedBox(height: 10),
          _buildInfoMessage(),
        ],
      ),
    );
  }
}

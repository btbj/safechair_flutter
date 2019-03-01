import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';
import './components/menu_nav.dart';
import './components/logout_btn.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/utils/nav_manager.dart';

import './subpages/chair_manage/chair_manage.dart';
import './subpages/chair_intro/chair_intro.dart';
import './subpages/temp_setting/temp_setting.dart';
import './subpages/pwd_change/pwd_change.dart';

// import 'package:safe_chair/models/Chair.dart';

class SettingPage extends StatefulWidget {
  @override
  SettingPageState createState() {
    return new SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
  String versionCode = '0.1.3';

  @override
  void initState() {
    super.initState();
  }


  Widget _buildChairManageBtn() {
    final String label = '座椅管理';
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return MenuNav(
        label: label,
        endLabel: model.currentChair == null ? '' : model.currentChair.name,
        onTap: () {
          print('nav to chair manage');
          NavManager.push(context, ChairManagePage()).then((_) {
            // initPageData();
          });
        },
      );
    });
  }

  Widget _buildChairIntroBtn() {
    final String label = '座椅说明';
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return MenuNav(
        label: label,
        endLabel: model.currentChair == null ? '' : model.currentChair.name,
        onTap: () {
          print('nav to chair intro');
          NavManager.push(context, ChairIntroPage());
        },
      );
    });
  }

  Widget _buildTempBtn() {
    final String label = '温度设置';
    return MenuNav(
      label: label,
      onTap: () {
        print('nav to temp control');
        NavManager.push(context, TempSettingPage());
      },
    );
  }

  Widget _buildPassBtn() {
    final String label = '密码设置';
    return MenuNav(
      label: label,
      onTap: () {
        print('nav to pass setting');
        NavManager.push(context, PwdChangePage());
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
    final TextStyle style = TextStyle(color: Colors.grey[700], fontSize: 12);
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('使用' + model.authUser.username + '登录', style: style),
          Text('版本号' + versionCode, style: style),
          Text('隐私政策', style: style),
        ],
      );
    });
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

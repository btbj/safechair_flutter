import 'package:flutter/material.dart';
import 'package:safe_chair/views/setting/setting.dart';
import 'package:safe_chair/utils/nav_manager.dart';

class HeadBar extends StatelessWidget {
  final String title;
  HeadBar({this.title});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    Widget _buildSettingBtn() {
      return FlatButton(
        child: Icon(
          Icons.settings,
          color: primaryColor,
        ),
        onPressed: () {
          print('setting');
          NavManager.push(context, SettingPage());
        },
      );
    }

    Widget _buildMessageBtn() {
      return FlatButton(
        child: Icon(
          Icons.message,
          color: primaryColor,
        ),
        onPressed: () {
          print('message');
        },
      );
    }

    Widget _buildTitle() {
      return Text(title, style: TextStyle(color: primaryColor, fontSize: 16));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildSettingBtn(),
        _buildTitle(),
        _buildMessageBtn(),
      ],
    );
  }
}

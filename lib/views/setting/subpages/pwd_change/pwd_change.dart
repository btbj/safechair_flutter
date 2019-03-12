import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';
import 'package:safe_chair/ui_elements/basic_btn.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/services/api.dart' as api;
import 'package:safe_chair/ui_elements/toast.dart';
import 'package:safe_chair/models/User.dart';

class PwdChangePage extends StatefulWidget {
  @override
  _PwdChangePageState createState() => _PwdChangePageState();
}

class _PwdChangePageState extends State<PwdChangePage> {
  MainModel _model;
  String usernameString = 'aaa@aaa.aaa';
  TextEditingController pwdCtr = TextEditingController();
  TextEditingController pwd2Ctr = TextEditingController();

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() {
    print('get user info');
    _model = ScopedModel.of(context);
    usernameString = _model.authUser.username;
  }

  Widget _buildChangeBtn() {
    Function onTap;
    if (pwdCtr.text == pwd2Ctr.text && pwdCtr.text.isNotEmpty) {
      onTap = () async {
        print('change');
        print(_model.authUser.token);
        try {
          final Map<String, dynamic> response = await api.post(
            context,
            api: '/user/do_change_pwd',
            body: {
              'token': _model.authUser.token,
              'new_pwd': pwdCtr.text,
            },
          );
          print('r: $response');

          User newUser = User(
            id: _model.authUser.id,
            token: _model.authUser.token,
            username: _model.authUser.username,
            password: pwdCtr.text,
          );

          await _model.setUser(newUser);

          Toast.show(context, response['message']);
          Navigator.pop(context);
        } catch (e) {
          print(e);
          Toast.show(context, e);
        }
      };
    }
    return BasicBtn(
      label: '修改',
      onTap: onTap,
    );
  }

  Widget _buildUsernameLine() {
    final TextStyle textStyle = TextStyle(color: Colors.grey);
    return ListTile(
      title: Row(
        children: <Widget>[
          Container(
            width: 120,
            child: Text('登录账户', style: textStyle),
          ),
          Expanded(
            child: Text(usernameString, style: textStyle),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordLine(
      {String label, String hintText, TextEditingController ctrl}) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return ListTile(
      title: Row(
        children: <Widget>[
          Container(
            width: 120,
            child: Text(label, style: TextStyle(color: primaryColor)),
          ),
          Expanded(
            child: TextField(
              controller: ctrl,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              cursorColor: primaryColor,
              style: TextStyle(color: Colors.white),
              obscureText: true,
              onChanged: (_) {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Divider(color: Colors.grey),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          _buildUsernameLine(),
          _buildDivider(),
          _buildPasswordLine(label: '新密码', hintText: '请输入密码', ctrl: pwdCtr),
          _buildDivider(),
          _buildPasswordLine(label: '确认密码', hintText: '请再次输入密码', ctrl: pwd2Ctr),
          _buildDivider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasicPlate(
      title: '密码设置',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20),
          _buildForm(),
          SizedBox(height: 20),
          _buildChangeBtn(),
        ],
      ),
    );
  }
}

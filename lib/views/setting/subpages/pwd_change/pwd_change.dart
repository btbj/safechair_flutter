import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';
import 'package:safe_chair/ui_elements/basic_btn.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/services/api.dart' as api;
import 'package:safe_chair/ui_elements/toast.dart';
import 'package:safe_chair/models/User.dart';
import 'package:safe_chair/lang/custom_localization.dart';

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
      label: CustomLocalizations.of(context).system('reset_password_btn_text'),
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
            child: Text(
                CustomLocalizations.of(context).system('password_login_count'),
                style: textStyle),
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
          _buildPasswordLine(
            label:
                CustomLocalizations.of(context).system('password_new_password'),
            hintText: CustomLocalizations.of(context).message('password_hint'),
            ctrl: pwdCtr,
          ),
          _buildDivider(),
          _buildPasswordLine(
            label: CustomLocalizations.of(context)
                .system('password_confirm_password'),
            hintText: CustomLocalizations.of(context).message('password_confirm_hint'),
            ctrl: pwd2Ctr,
          ),
          _buildDivider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasicPlate(
      title: CustomLocalizations.of(context).system('password_setting_title'),
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

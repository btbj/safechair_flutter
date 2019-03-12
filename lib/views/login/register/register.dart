import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';
import 'package:safe_chair/ui_elements/input_box.dart';
import 'package:safe_chair/ui_elements/basic_btn.dart';
import 'package:safe_chair/ui_elements/code_btn.dart';
import 'package:safe_chair/utils/nav_manager.dart';

import 'package:safe_chair/views/policy/service_policy.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameCtr = TextEditingController();
  final TextEditingController codeCtr = TextEditingController();
  final TextEditingController passwordCtr = TextEditingController();
  String usernameForCode = '';

  Widget _buildTitle() {
    Color primaryColor = Theme.of(context).primaryColor;
    return Text(
      '欢迎加入',
      style: TextStyle(color: primaryColor, fontSize: 20),
    );
  }

  Widget _buildUsernameTextField() {
    return InputBox(
      controller: usernameCtr,
      icon: Icons.email,
      hintText: '请输入邮箱',
      onChanged: (value) {
        setState(() {
          usernameForCode = value;
        });
      },
    );
  }

  Widget _buildCodeTextField() {
    return InputBox(
      controller: codeCtr,
      icon: Icons.more_horiz,
      hintText: '请输入验证码',
      suffix: _buildGetCodeBtn(),
    );
  }

  Widget _buildGetCodeBtn() {
    return CodeBtn(username: usernameForCode);
  }

  Widget _buildPasswordTextField() {
    return InputBox(
      controller: passwordCtr,
      icon: Icons.lock_open,
      hintText: '请输入密码',
    );
  }

  Widget _buildRegisterForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 55.0, vertical: 5.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildUsernameTextField(),
            SizedBox(height: 15),
            _buildCodeTextField(),
            SizedBox(height: 15),
            _buildPasswordTextField(),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterBtn() {
    return BasicBtn(
      label: '加入',
      onTap: () {
        print('username: ${usernameCtr.text}');
        print('code: ${codeCtr.text}');
        print('password: ${passwordCtr.text}');
      },
    );
  }

  Widget _buildPolicyInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '注册即代表阅读并同意',
          style: TextStyle(color: Colors.grey[700], fontSize: 12),
        ),
        GestureDetector(
          child: Text(
            '服务条款',
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),
          ),
          onTap: () {
            print('service policy');
            NavManager.push(context, ServicePolicyPage());
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasicPlate(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 100),
          _buildTitle(),
          SizedBox(height: 20),
          _buildRegisterForm(),
          SizedBox(height: 20),
          _buildRegisterBtn(),
          SizedBox(height: 10),
          _buildPolicyInfo(),
        ],
      ),
    );
  }
}

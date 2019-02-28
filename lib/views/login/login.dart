import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_model/main.dart';

import 'package:safe_chair/ui_elements/basic_btn.dart';
import 'package:safe_chair/ui_elements/input_box.dart';
import './components/logo_box.dart';

import 'package:safe_chair/views/register/register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  MainModel _model;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameCtr = TextEditingController();
  final TextEditingController passwordCtr = TextEditingController();

  @override
  void initState() {
    _model = ScopedModel.of(context);
    super.initState();
  }

  Widget _buildUsernameTextField() {
    return InputBox(
      controller: usernameCtr,
      icon: Icons.person_outline,
      hintText: '请输入手机号/邮箱',
    );
  }

  Widget _buildPasswordTextField() {
    return InputBox(
      controller: passwordCtr,
      icon: Icons.lock_outline,
      hintText: '请输入密码',
      obscureText: true,
    );
  }

  Widget _buildRegisterBtn() {
    return GestureDetector(
      child: Text(
        '用户注册',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      onTap: () {
        print('register');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      },
    );
  }

  Widget _buildResetPwdBtn() {
    return GestureDetector(
      child: Text(
        '忘记密码',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      onTap: () {
        print('reset pwd');
      },
    );
  }

  Widget _buildButonRow() {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _buildRegisterBtn(),
        Container(
          width: 1,
          height: 15,
          color: primaryColor,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
        ),
        _buildResetPwdBtn(),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 55.0, vertical: 5.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildUsernameTextField(),
            SizedBox(height: 15),
            _buildPasswordTextField(),
            SizedBox(height: 15),
            _buildButonRow(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LogoBox(),
                SizedBox(height: 100),
                _buildLoginForm(),
                SizedBox(height: 100),
                BasicBtn(
                  label: '登录',
                  onTap: () {
                    print('username: ${usernameCtr.text}');
                    print('password: ${passwordCtr.text}');
                    _model.login();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

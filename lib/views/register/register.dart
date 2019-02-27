import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';
import 'package:safe_chair/ui_elements/input_box.dart';
import 'package:safe_chair/ui_elements/basic_btn.dart';
import './components/code_btn.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameCtr = TextEditingController();
  final TextEditingController codeCtr = TextEditingController();
  final TextEditingController passwordCtr = TextEditingController();

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
      hintText: '请输入手机号/邮箱',
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
    return CodeBtn(controller: usernameCtr);
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
          BasicBtn(
            label: '加入',
            onTap: () {
              print('username: ${usernameCtr.text}');
              print('code: ${codeCtr.text}');
              print('password: ${passwordCtr.text}');
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_model/main.dart';

import 'package:safe_chair/ui_elements/basic_btn.dart';
import 'package:safe_chair/ui_elements/input_box.dart';
import './components/logo_box.dart';

import './register/register.dart';
import './resetpwd/resetpwd.dart';

import 'package:safe_chair/views/policy/service_policy.dart';
import 'package:safe_chair/services/api.dart' as api;
import 'package:safe_chair/ui_elements/toast.dart';
import 'package:safe_chair/models/User.dart';

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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetpwdPage()),
        );
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

  Widget _buildLoginBtn() {
    return BasicBtn(
      label: '登录',
      onTap: () async {
        print('username: ${usernameCtr.text}');
        print('password: ${passwordCtr.text}');
        if (passwordCtr.text.isEmpty || usernameCtr.text.isEmpty) return;

        try {
          final Map<String, dynamic> response = await api.post(api: '/user/do_login', body: {
            'username': usernameCtr.text,
            'password': passwordCtr.text,
          });
          print('r: $response');

          _model.login(User(
            id: response['data']['user']['id'],
            token: response['data']['user']['token'],
            username: usernameCtr.text,
            password: passwordCtr.text,
          ));
        } catch (e) {
          print(e);
          Toast.show(context, e);
        }
      },
    );
  }

  Widget _buildPolicyInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '登录即代表阅读并同意',
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServicePolicyPage()),
            );
          },
        )
      ],
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
                _buildLoginBtn(),
                SizedBox(height: 10),
                _buildPolicyInfo(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

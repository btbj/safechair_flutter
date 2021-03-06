import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_model/main.dart';

import 'package:safe_chair/utils/nav_manager.dart';
import 'package:safe_chair/ui_elements/basic_btn.dart';
import 'package:safe_chair/ui_elements/input_box.dart';
import './components/logo_box.dart';

import './register/register.dart';
import './resetpwd/resetpwd.dart';

import 'package:safe_chair/views/policy/service_policy.dart';
import 'package:safe_chair/services/api.dart' as api;
import 'package:safe_chair/ui_elements/toast.dart';
import 'package:safe_chair/models/User.dart';

import 'package:safe_chair/lang/custom_localization.dart';

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
      hintText: CustomLocalizations.of(context).message('email_hint'),
    );
  }

  Widget _buildPasswordTextField() {
    return InputBox(
      controller: passwordCtr,
      icon: Icons.lock_outline,
      hintText: CustomLocalizations.of(context).message('password_hint'),
      obscureText: true,
    );
  }

  Widget _buildRegisterBtn() {
    return GestureDetector(
      child: Text(
        CustomLocalizations.of(context).system('register_nav_text'),
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      onTap: () {
        print('register');
        NavManager.push(context, RegisterPage());
      },
    );
  }

  Widget _buildResetPwdBtn() {
    return GestureDetector(
      child: Text(
        CustomLocalizations.of(context).system('resetpwd_nav_text'),
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      onTap: () {
        print('reset pwd');
        NavManager.push(context, ResetpwdPage());
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
      label: CustomLocalizations.of(context).system('login_btn_text'),
      onTap: () async {
        print('username: ${usernameCtr.text}');
        print('password: ${passwordCtr.text}');
        if (passwordCtr.text.isEmpty || usernameCtr.text.isEmpty) return;

        try {
          final Map<String, dynamic> response = await api.post(
            context,
            api: '/user/do_login',
            body: {
              'username': usernameCtr.text,
              'password': passwordCtr.text,
            },
          );
          print('r: $response');

          final User newUser = User(
            id: response['data']['user']['id'],
            token: response['data']['user']['token'],
            username: usernameCtr.text,
            password: passwordCtr.text,
          );
          _model.login(newUser);
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
          CustomLocalizations.of(context).message('login_to_agree'),
          style: TextStyle(color: Colors.grey[700], fontSize: 12),
        ),
        GestureDetector(
          child: Text(
            CustomLocalizations.of(context).system('policy_nav_text'),
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

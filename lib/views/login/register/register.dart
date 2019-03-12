import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';
import 'package:safe_chair/ui_elements/input_box.dart';
import 'package:safe_chair/ui_elements/basic_btn.dart';
import 'package:safe_chair/ui_elements/code_btn.dart';
import 'package:safe_chair/utils/nav_manager.dart';

import 'package:safe_chair/views/policy/service_policy.dart';
import 'package:safe_chair/services/api.dart' as api;
import 'package:safe_chair/ui_elements/toast.dart';

import 'package:safe_chair/lang/custom_localization.dart';

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
      CustomLocalizations.of(context).system('register_title'),
      // 'title',
      style: TextStyle(color: primaryColor, fontSize: 20),
    );
  }

  Widget _buildUsernameTextField() {
    return InputBox(
      controller: usernameCtr,
      icon: Icons.email,
      hintText: CustomLocalizations.of(context).message('email_hint'),
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
      hintText: CustomLocalizations.of(context).message('code_hint'),
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
      hintText: CustomLocalizations.of(context).message('password_hint'),
      obscureText: true,
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
      label: CustomLocalizations.of(context).system('register_btn_text'),
      onTap: () async {
        print('username: ${usernameCtr.text}');
        print('code: ${codeCtr.text}');
        print('password: ${passwordCtr.text}');

        if (passwordCtr.text.isEmpty ||
            usernameCtr.text.isEmpty ||
            codeCtr.text.isEmpty) return;
        try {
          final Map<String, dynamic> response = await api.post(
            context,
            api: '/user/do_reg',
            body: {
              'username': usernameCtr.text,
              'password': passwordCtr.text,
              'code': codeCtr.text,
            },
          );
          print('r: $response');

          Toast.show(context, response['message']);
          Navigator.pop(context);
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
          CustomLocalizations.of(context).message('register_to_agree'),
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

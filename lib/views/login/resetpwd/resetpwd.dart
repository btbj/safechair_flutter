import 'package:flutter/material.dart';
import 'package:safe_chair/ui_elements/basic_plate.dart';
import 'package:safe_chair/ui_elements/input_box.dart';
import 'package:safe_chair/ui_elements/basic_btn.dart';
import 'package:safe_chair/ui_elements/code_btn.dart';

import 'package:safe_chair/services/api.dart' as api;
import 'package:safe_chair/ui_elements/toast.dart';
import 'package:safe_chair/lang/custom_localization.dart';

class ResetpwdPage extends StatefulWidget {
  @override
  _ResetpwdPageState createState() => _ResetpwdPageState();
}

class _ResetpwdPageState extends State<ResetpwdPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameCtr = TextEditingController();
  final TextEditingController codeCtr = TextEditingController();
  final TextEditingController passwordCtr = TextEditingController();
  String usernameForCode = '';

  // Widget _buildTitle() {
  //   Color primaryColor = Theme.of(context).primaryColor;
  //   return Text(
  //     '欢迎加入',
  //     style: TextStyle(color: primaryColor, fontSize: 20),
  //   );
  // }

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
    return CodeBtn(
      username: usernameForCode,
      getCodeText: CustomLocalizations.of(context).system('code_btn_get_code'),
      waitText: CustomLocalizations.of(context).system('code_btn_seconds'),
    );
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

  Widget _buildResetBtn() {
    return BasicBtn(
      label: CustomLocalizations.of(context).system('resetpwd_btn'),
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
            api: '/user/do_reset_pwd',
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

  @override
  Widget build(BuildContext context) {
    return BasicPlate(
      title: CustomLocalizations.of(context).system('resetpwd_title'),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 100),
          SizedBox(height: 20),
          _buildRegisterForm(),
          SizedBox(height: 20),
          _buildResetBtn(),
        ],
      ),
    );
  }
}

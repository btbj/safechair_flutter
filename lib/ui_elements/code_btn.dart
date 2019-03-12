import 'dart:async';
import 'package:flutter/material.dart';

class CodeBtn extends StatefulWidget {
  final String username;
  final int countSeconds;
  CodeBtn({this.username, this.countSeconds = 5});

  @override
  _CodeBtnState createState() => _CodeBtnState();
}

class _CodeBtnState extends State<CodeBtn> {
  int _seconds = 0;
  bool _isCounting = false;
  String _btnText = '获取验证码';

  void startTimer() {
    // 初始化
    _isCounting = true;
    _seconds = widget.countSeconds;
    _btnText = _seconds.toString() + 's后获取';
    setState(() {});
    // 定时操作
    Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds--;
      _btnText = _seconds.toString() + 's后获取';
      if (_seconds == 0) {
        timer.cancel();
        _btnText = '获取验证码';
        _isCounting = false;
      }
      setState(() {});
    });
  }

  bool usernameCheck(String username) {
    if (username.isEmpty) return false;
    RegExp regExp =
        RegExp(r'^\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}$');
    bool hasMatch = regExp.hasMatch(username);
    return hasMatch;
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Function onPressed;
    if (usernameCheck(widget.username) && !_isCounting) {
      onPressed = () {
        startTimer();
      };
    }

    return FlatButton(
      child: Text(_btnText),
      onPressed: onPressed,
      color: primaryColor,
      disabledColor: Colors.grey,
      padding: EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(12.0),
          bottomEnd: Radius.circular(12.0),
        ),
      ),
    );
  }
}

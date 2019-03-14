import 'dart:async';
import 'package:flutter/material.dart';
import 'package:safe_chair/services/api.dart' as api;
import 'package:safe_chair/ui_elements/toast.dart';

class CodeBtn extends StatefulWidget {
  final String username;
  final int countSeconds;
  final String getCodeText;
  final String waitText;
  CodeBtn({this.username, this.countSeconds = 120, this.getCodeText, this.waitText});

  @override
  _CodeBtnState createState() => _CodeBtnState();
}

class _CodeBtnState extends State<CodeBtn> {
  Timer _timer;
  int _seconds = 0;
  bool _isCounting = false;
  String _btnText;

  @override
  void initState() {
    _btnText = widget.getCodeText;
    super.initState();
  }

  void startTimer() {
    // 初始化
    _isCounting = true;
    _seconds = widget.countSeconds;
    _btnText = _seconds.toString() + widget.waitText;
    setState(() {});
    // 定时操作
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds--;
      _btnText = _seconds.toString() + widget.waitText;
      setState(() {});
      if (_seconds == 0) {
        _cancelTimer();
        setState(() {});
      }
    });
  }

  void _cancelTimer() {
    _seconds = 0;
    _btnText = widget.getCodeText;
    _isCounting = false;
    _timer?.cancel();
  }

  bool usernameCheck(String username) {
    if (username.isEmpty) return false;
    RegExp regExp =
        RegExp(r'^\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}$');
    bool hasMatch = regExp.hasMatch(username);
    return hasMatch;
  }

  void requestCode(String username) async {
    try {
      final Map<String, dynamic> response = await api.post(
        context,
        api: '/user/send_email',
        body: {'username': username},
      );
      print('r: $response');

      Toast.show(context, response['message']);
    } catch (e) {
      print(e);
      Toast.show(context, e);
      _cancelTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Function onPressed;
    if (usernameCheck(widget.username) && !_isCounting) {
      onPressed = () {
        requestCode(widget.username);
        startTimer();
      };
    }

    return FlatButton(
      child: Text(_btnText),
      onPressed: onPressed,
      color: primaryColor,
      disabledColor: Colors.grey,
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(12.0),
          bottomEnd: Radius.circular(12.0),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }
}

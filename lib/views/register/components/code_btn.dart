import 'dart:async';
import 'package:flutter/material.dart';

class CodeBtn extends StatefulWidget {
  final TextEditingController controller;
  final int countdown;
  CodeBtn({this.controller, this.countdown = 5});

  @override
  _CodeBtnState createState() => _CodeBtnState();
}

class _CodeBtnState extends State<CodeBtn> {
  Timer _timer;
  int _seconds;
  bool _counting = false;
  String _verifyStr = '获取验证码';

  @override
  void initState() {
    super.initState();
    _seconds = widget.countdown;
    print(_seconds);
  }

  void callback() {
    print('55555');
    _timer.cancel();
    _timer = null;
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        _seconds = widget.countdown;
        setState(() {});
        return;
      }
      _seconds--;
      _verifyStr = _seconds.toString() + 's后获取';
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '获取验证码';
        _counting = false;
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    var onPressed =
        widget.controller.text.length > 5 && !_counting
            ? () {
                print('get code');
                startTimer();
                _verifyStr = _seconds.toString() + 's后获取';
                setState(() {
                  _counting = true;
                });
              }
            : null;

    return FlatButton(
      child: Text(_verifyStr),
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

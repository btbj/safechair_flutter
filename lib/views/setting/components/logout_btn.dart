import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:safe_chair/ui_elements/basic_btn.dart';

class LogoutBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return BasicBtn(
          label: '登出',
          onTap: () {
            Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
            model.logout();
          },
        );
      },
    );
  }
}

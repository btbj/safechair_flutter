import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_model/main.dart';
import '../login/login.dart';
import './components/tab_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool isSignin = false;
  MainModel _model;
  @override
  void initState() {
    _model = ScopedModel.of(context);
    _model.authSubject.listen((bool isSignin) {
      setState(() {
        this.isSignin = isSignin;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: isSignin ? TabPage() : LoginPage(),
    );
  }
}

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
    _model.autoLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: isSignin ? TabPage() : LoginPage(),
        // floatingActionButton: IconButton(
        //   color: Colors.blue,
        //   icon: Icon(Icons.language),
        //   onPressed: () {
        //     print('change');
        //     _model.toggleEnglish();
        //   },
        // ),
      ),
    );
  }
}

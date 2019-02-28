import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';

import './scoped_model/main.dart';
import './views/root/root.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();

  void setStatusBarBrightness() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarBrightness();

    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 217, 132, 44),
        ),
        home: RootPage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:safe_chair/lang/custom_localization.dart';
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

GlobalKey<FreeLocalizationsState> freeLocalizationStateKey =
    GlobalKey<FreeLocalizationsState>();

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
        onGenerateTitle: (context) {
          return CustomLocalizations.of(context).appTitle;
        },
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 217, 132, 44),
        ),
        // home: RootPage(),
        home: Builder(
          builder: (context) {
            return FreeLocalizations(
              key: freeLocalizationStateKey,
              child: RootPage(),
            );
          },
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          CustomLocalizaionsDelegate.delegate,
        ],
        supportedLocales: [
          const Locale('zh', 'CH'),
          const Locale('en', 'US'),
        ],
      ),
    );
  }
}

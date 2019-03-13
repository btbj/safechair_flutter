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

class MyAppState extends State<MyApp> {
  MainModel _model;
  Locale _locale;

  @override
  void initState() {
    _model = MainModel();
    print('init model');
    _model.localeSubject.listen((newLocale) {
      setState(() {
        _locale = newLocale;
      });
    });
    super.initState();
  }

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
    print('build app');
    setStatusBarBrightness();

    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        onGenerateTitle: (context) {
          return CustomLocalizations.of(context).system('app_title');
        },
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 217, 132, 44),
        ),
        home: RootPage(),
        locale: _locale,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          CustomLocalizaionsDelegate.delegate,
        ],
        supportedLocales: [
          const Locale('zh'),
          const Locale('en'),
        ],
        localeResolutionCallback: (locale, supportedLocals) {
          // print('${locale.languageCode}, ${locale.countryCode}');
          _model.initLocale(locale);
        },
      ),
    );
  }
}

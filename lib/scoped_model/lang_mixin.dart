import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:rxdart/subjects.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:safe_chair/lang/custom_localization.dart';

mixin LangMixin on Model {
  Locale _locale;
  Locale get locale => _locale;

  PublishSubject<Locale> _localeSubject = PublishSubject();
  PublishSubject<Locale> get localeSubject => this._localeSubject;

  bool _isEN = false;
  bool get isEN => _isEN;

  void initLocale(Locale locale) {
    if (_locale != null) return;
    _locale = locale;
  }

  void toggleEnglish() {
    if (_isEN) {
      _localeSubject.add(Locale('zh'));
    } else {
      _localeSubject.add(Locale('en'));
    }
    _isEN = !_isEN;
  }
}

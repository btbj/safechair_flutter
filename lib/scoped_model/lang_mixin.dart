import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:rxdart/subjects.dart';

import 'package:safe_chair/store/langStore.dart';

mixin LangMixin on Model {
  Locale _locale;

  bool get isEN {
    if (_locale == null) return false;
    return _locale.languageCode == 'en';
  }

  PublishSubject<Locale> _localeSubject = PublishSubject();
  PublishSubject<Locale> get localeSubject => this._localeSubject;

  void initLocale(Locale locale) async {
    if (_locale != null) return;
    _locale = locale;

    Locale savedLocale = await LangStore.getLang();
    if (savedLocale != null) {
      _locale = savedLocale;
      _localeSubject.add(savedLocale);
    }
  }

  Future toggleEnglish() async {
    if (_locale.languageCode != 'zh') {
      _locale = Locale('zh');
    } else {
      _locale = Locale('en');
    }
    _localeSubject.add(_locale);
    await LangStore.setLang(_locale);
    return;
  }
}

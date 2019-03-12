import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/lang/custom_localization.dart';

mixin LangMixin on Model {
  GlobalKey<FreeLocalizationsState> _freeLocalizationStateKey;
  GlobalKey<FreeLocalizationsState> get freeLocalizationStateKey =>
      _freeLocalizationStateKey;

  bool _isEN = false;
  bool get isEN => _isEN;

  GlobalKey<FreeLocalizationsState> createFreeLocalizationStateKey() {
    this._freeLocalizationStateKey = GlobalKey<FreeLocalizationsState>();
    return this._freeLocalizationStateKey;
  }

  void toggleEnglish() {
    if (_isEN) {
      _freeLocalizationStateKey.currentState.changeLocale(Locale('zh', 'CH'));
    } else {
      _freeLocalizationStateKey.currentState.changeLocale(Locale('en', 'US'));
    }
    _isEN = !_isEN;
  }
}

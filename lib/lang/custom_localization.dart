import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'dart:async';
import './resource/en.dart' as en;
import './resource/zh.dart' as zh;

class CustomLocalizations {
  final Locale locale;

  CustomLocalizations(this.locale);

  static Map<String, Map<String, Map<String, String>>> _localizedValues = {
    'en': en.resource,
    'zh': zh.resource,
  };

  String system(String key) {
    return _localizedValues[locale.languageCode]['system'][key];
  }

  String message(String key) {
    return _localizedValues[locale.languageCode]['message'][key];
  }

  static CustomLocalizations of(BuildContext context) {
    return Localizations.of(context, CustomLocalizations);
  }
}

class CustomLocalizaionsDelegate
    extends LocalizationsDelegate<CustomLocalizations> {
  const CustomLocalizaionsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<CustomLocalizations> load(Locale locale) {
    return SynchronousFuture<CustomLocalizations>(CustomLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<CustomLocalizations> old) {
    return false;
  }

  static CustomLocalizaionsDelegate delegate =
      const CustomLocalizaionsDelegate();
}

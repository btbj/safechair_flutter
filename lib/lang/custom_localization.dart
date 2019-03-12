import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'dart:async';

class CustomLocalizations {
  final Locale locale;

  CustomLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'Welldon',
      'login_btn_text': 'Login',
    },
    'zh': {
      'app_title': '惠尔顿',
      'login_btn_text': '登录',
    }
  };

  String get appTitle {
    return _localizedValues[locale.languageCode]['app_title'];
  }

  String get loginBtnText {
    return _localizedValues[locale.languageCode]['login_btn_text'];
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

class FreeLocalizations extends StatefulWidget {
  final Widget child;
  FreeLocalizations({Key key, this.child}) : super(key: key);

  @override
  FreeLocalizationsState createState() => FreeLocalizationsState();
}

class FreeLocalizationsState extends State<FreeLocalizations> {
  Locale _locale = const Locale('zh', 'CH');

  void changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: _locale,
      child: widget.child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class LangStore {
  static final String _langKey = 'StoredLang';

  static Future<Locale> getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedLang = prefs.getString(_langKey);
    if (storedLang == null) return null;
    return Locale(storedLang);
  }

  static Future setLang(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, locale.languageCode);
    return;
  }
}
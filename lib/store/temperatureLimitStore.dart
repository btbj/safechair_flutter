import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class TemperatureLimit {
  final int high;
  final int low;
  final bool highSwitch;
  final bool lowSwitch;
  final bool isF;
  TemperatureLimit({this.high, this.low, this.highSwitch, this.lowSwitch, this.isF});
}

class TemperatureLimitStore {
  static final String limitKey = 'TemperatureLimit';

  static Future<TemperatureLimit> getLimit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String limitString = prefs.getString(limitKey);
    if (limitString == null) {
      return TemperatureLimit(
          high: 30, low: 20, highSwitch: false, lowSwitch: false, isF: false);
    } else {
      final Map<String, dynamic> limitMap = jsonDecode(limitString);
      return TemperatureLimit(
        high: limitMap['high'],
        low: limitMap['low'],
        highSwitch: limitMap['highSwitch'],
        lowSwitch: limitMap['lowSwitch'],
        isF: limitMap['isF'],
      );
    }
  }

  static Future saveLimit(TemperatureLimit temperatureLimit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final Map<String, dynamic> limitMap = {
      'high': temperatureLimit.high,
      'low': temperatureLimit.low,
      'highSwitch': temperatureLimit.highSwitch,
      'lowSwitch': temperatureLimit.lowSwitch,
      'isF':temperatureLimit.isF,
    };

    final newDataString = jsonEncode(limitMap);
    await prefs.setString(limitKey, newDataString);
    return;
  }
}

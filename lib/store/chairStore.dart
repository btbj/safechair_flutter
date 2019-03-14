import 'package:shared_preferences/shared_preferences.dart';
import 'package:safe_chair/models/Chair.dart';
import 'dart:async';
import 'dart:convert';

class ChairStore {
  static final String listKey = 'ChairList';
  static final String currentKey = 'CurrentChair';

  static Future getChairMap() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String listString = (prefs.getString(listKey) ?? '{}');
    final Map<String, dynamic> chairsMap = jsonDecode(listString);
    return chairsMap;
  }

  static Future saveChair(Chair chair) async {
    final savedChair = await getChairMap();
    if (savedChair.containsKey(chair.uuid)) return;

    savedChair[chair.uuid] = {
      'uuid': chair.uuid,
      'name': chair.name,
      'model': chair.model,
      'enName': chair.enName,
      'enModel': chair.enModel,
    };

    final prefs = await SharedPreferences.getInstance();
    final newDataString = jsonEncode(savedChair);
    await prefs.setString(listKey, newDataString);
    return;
  }

  static Future removeChair(Chair chair) async {
    final Map<String, dynamic> savedChair = await getChairMap();
    if (!savedChair.containsKey(chair.uuid)) return;

    final Chair currentChair = await getCurrentChair();
    if (currentChair != null && currentChair.uuid == chair.uuid) {
      await setCurrentChair(null);
    }

    savedChair.remove(chair.uuid);

    final prefs = await SharedPreferences.getInstance();
    final newDataString = jsonEncode(savedChair);
    await prefs.setString(listKey, newDataString);
    return;
  }

  static Future<Chair> getCurrentChair() async {
    final prefs = await SharedPreferences.getInstance();
    final chairString = prefs.getString(currentKey);
    if (chairString == null) return null;

    final Map<String, dynamic> chairMap = jsonDecode(chairString);
    return Chair(
      uuid: chairMap['uuid'],
      model: chairMap['model'],
      name: chairMap['name'],
      enName: chairMap['enName'],
      enModel: chairMap['enModel'],
    );
  }

  static Future<Chair> setCurrentChair(Chair chair) async {
    // print('set chair ${chair.uuid} as current');
    final prefs = await SharedPreferences.getInstance();
    if (chair == null) {
      await prefs.setString(currentKey, null);
      return null;
    }
    final Chair currentChair = await getCurrentChair();
    if (currentChair != null && currentChair.uuid == chair.uuid) {
      await prefs.setString(currentKey, null);
      return null;
    } else {
      final Map<String, dynamic> chairMap = {
        'uuid': chair.uuid,
        'name': chair.name,
        'model': chair.model,
        'enName': chair.enName,
        'enModel': chair.enModel,
      };
      final String chairString = jsonEncode(chairMap);

      await prefs.setString(currentKey, chairString);
      return chair;
    }
  }
}

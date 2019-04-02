import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:safe_chair/lang/custom_localization.dart';

enum NotificationType {
  enterRegion,
  exitRegion,
  babyInCarWhenLeaving,
  installErr,
  lowBattery,
  highTemp,
  lowTemp,
}

class NotificationManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future init() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    return flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future show(BuildContext context, NotificationType type) async {
    String sound = getSoundType(type);
    String message = getMessage(context, type);

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(presentSound: true, sound: sound);
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin
        .show(0, '', message, platformChannelSpecifics);
    return;
  }

  String getSoundType(NotificationType type) {
    String sound;
    switch (type) {
      case NotificationType.babyInCarWhenLeaving:
        sound = 'baby_in_car_alert.caf';
        break;
      case NotificationType.enterRegion:
        sound = 'enter_region.caf';
        break;
      case NotificationType.exitRegion:
        sound = 'exit_region.caf';
        break;
      case NotificationType.installErr:
        sound = 'install_err.caf';
        break;
      case NotificationType.lowBattery:
        sound = 'low_battery.caf';
        break;
      case NotificationType.highTemp:
        sound = 'temp_alert.caf';
        break;
      case NotificationType.lowTemp:
        sound = 'temp_alert.caf';
        break;
      default:
    }
    return sound;
  }

  String getMessage(BuildContext context, NotificationType type) {
    String message;
    switch (type) {
      case NotificationType.babyInCarWhenLeaving:
        message = CustomLocalizations.of(context).message('alert_baby_in_car');
        break;
      case NotificationType.installErr:
        message = CustomLocalizations.of(context).message('alert_install_err');
        break;
      case NotificationType.lowBattery:
        message = CustomLocalizations.of(context).message('alert_low_battery');
        break;
      case NotificationType.highTemp:
        message = CustomLocalizations.of(context).message('alert_high_temp');
        break;
      case NotificationType.lowTemp:
        message = CustomLocalizations.of(context).message('alert_low_temp');
        break;
      case NotificationType.enterRegion:
        message = CustomLocalizations.of(context).message('notify_enter');
        break;
      case NotificationType.exitRegion:
        message = CustomLocalizations.of(context).message('notify_exit');
        break;
      default:
        message = 'error';
    }
    return message;
  }
}

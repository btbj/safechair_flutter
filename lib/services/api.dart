import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:safe_chair/config.dart' as config;

// const host = 'http://192.168.0.33/2018/safe_chair/index.php';
// const host = 'http://php.gooduo.net/safe_chair/index.php/';
const String host = config.api_host; 

Future post(BuildContext context,
    {String api, dynamic body}) async {
  MainModel _model = ScopedModel.of(context);
  if (_model.isEN) {
    body['lang'] = 'en';
  }

  try {
    final http.Response response = await http.post(
      '$host$api',
      body: json.encode(body),
    );
    if (response.statusCode != 200) throw ('网络错误: ${response.statusCode}');
    final Map<String, dynamic> res = json.decode(response.body);

    print('body: ${body.toString()}');
    print('res: $res');
    if (res['error_code'] == 110) throw ('token error');
    if (!res['success']) throw (res['message']);
    return json.decode(response.body);
  } catch (e) {
    // print(e);
    if (e == 'token error') {
      _model.logout(context);
    } else if (e is String) {
      throw (e);
    } else {
      print(e);
      throw ('未知错误');
    }
  }
}

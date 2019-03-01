import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/scoped_model/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// const host = 'http://192.168.0.33/2018/safe_chair/index.php';
const host = 'http://php.gooduo.net/safe_chair/index.php/';

Future post(BuildContext context,
    {String api, dynamic body}) async {
  MainModel _model = ScopedModel.of(context);

  try {
    final http.Response response = await http.post(
      '$host$api',
      body: json.encode(body),
    );
    if (response.statusCode != 200) throw ('网络错误: ${response.statusCode}');
    final Map<String, dynamic> res = json.decode(response.body);

    if (res['error_code'] == 110) throw ('请重新登录');
    if (!res['success']) throw (res['message']);
    return json.decode(response.body);
  } catch (e) {
    // print(e);
    if (e == '请重新登录') {
      _model.logout(context);
    } else if (e is String) {
      throw (e);
    } else {
      print(e);
      throw ('未知错误');
    }
  }
}

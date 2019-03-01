import 'package:http/http.dart' as http;
import 'dart:convert';

const host = 'http://192.168.0.33/2018/safe_chair/index.php';

Future<Map<String, dynamic>> post({String api, dynamic body}) async {
  try {
    final http.Response response = await http.post(
      '$host$api',
      body: json.encode(body),
    );
    if (response.statusCode != 200) throw('网络错误: ${response.statusCode}');
    final Map<String, dynamic> res = json.decode(response.body);

    if (!res['success']) throw(res['message']);
    return json.decode(response.body);
  } catch (e) {
    // print(e);
    throw(e);
  }
}

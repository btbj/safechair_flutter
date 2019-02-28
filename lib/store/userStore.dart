import 'package:shared_preferences/shared_preferences.dart';
import 'package:safe_chair/models/User.dart';

class UserStore {
  static Future saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userid', user.id);
    prefs.setString('username', user.username);
    prefs.setString('password', user.password);
    prefs.setString('token', user.token);
    return;
  }

  static Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('userid');
    final String username = prefs.getString('username');
    final String password = prefs.getString('password');
    final String token = prefs.getString('token');

    if (id == null) return null;

    return User(id: id, username: username, password: password, token: token);
  }

  static Future removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userid');
    prefs.remove('username');
    prefs.remove('password');
    prefs.remove('token');
    return;
  }
}

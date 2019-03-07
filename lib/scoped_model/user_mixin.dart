import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:safe_chair/models/User.dart';
import 'package:safe_chair/store/userStore.dart';
// import 'package:safe_chair/services/api.dart' as api;
import 'package:safe_chair/utils/nav_manager.dart';


mixin UserMixin on Model {
  User _authUser;
  User get authUser => _authUser;

  PublishSubject<bool> _authSubject = PublishSubject();
  PublishSubject<bool> get authSubject => this._authSubject;

  void login(User user) async {
    print('login');
    _authUser = user;
    await UserStore.saveUser(user);
    _authSubject.add(true);
    notifyListeners();
  }

  void logout(BuildContext context) async {
    print('logout');
    _authUser = null;
    await UserStore.removeUser();
    _authSubject.add(false);
    notifyListeners();
    NavManager.logout(context);
  }

  void autoLogin(BuildContext context) async {
    final User user = await UserStore.getUser();
    if (user == null) {
      print('no user');
      return;
    }

    _authUser = user;
    _authSubject.add(true);
    notifyListeners();

    // try {
    //   final Map<String, dynamic> response =
    //       await api.post(context, api: '/user/do_login', body: {
    //     'username': user.username,
    //     'password': user.password,
    //   });
    //   print('auto login: $response');

    //   final User newUser = User(
    //     id: response['data']['user']['id'],
    //     token: response['data']['user']['token'],
    //     username: user.username,
    //     password: user.password,
    //   );

    //   _authUser = newUser;
    //   await UserStore.saveUser(newUser);
    //   _authSubject.add(true);
    //   notifyListeners();
    // } catch (e) {
    //   print(e);
    // }
  }
}

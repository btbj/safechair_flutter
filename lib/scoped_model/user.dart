import 'package:scoped_model/scoped_model.dart';
import 'package:rxdart/subjects.dart';

mixin User on Model {
  PublishSubject<bool> _authSubject = PublishSubject();
  PublishSubject<bool> get authSubject => this._authSubject;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  void login() {
    print('login');
    _isAuthenticated = true;
    _authSubject.add(_isAuthenticated);
    notifyListeners();
  }

  void logout() {
    print('logout');
    _isAuthenticated = false;
    _authSubject.add(_isAuthenticated);
    notifyListeners();
  }
}

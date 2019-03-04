import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/models/Chair.dart';
import 'package:safe_chair/store/chairStore.dart';
import 'package:rxdart/subjects.dart';

mixin ChairMixin on Model {
  Chair _currentChair;
  Chair get currentChair => _currentChair;

  PublishSubject<bool> _chairSubject = PublishSubject();
  PublishSubject<bool> get chairSubject => this._chairSubject;

  void initCurrentChair() async {
    _currentChair = await ChairStore.getCurrentChair();
    notifyListeners();
  }

  Future setCurrentChair(Chair chair) async {
    print('set chair ${chair.uuid}');
    _currentChair = await ChairStore.setCurrentChair(chair);
    _chairSubject.add(_currentChair != null);
    notifyListeners();
    return;
  }
}
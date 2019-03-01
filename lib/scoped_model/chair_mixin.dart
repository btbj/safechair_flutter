import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:safe_chair/models/Chair.dart';
import 'package:safe_chair/store/chairStore.dart';

mixin ChairMixin on Model {
  Chair _currentChair;
  Chair get currentChair => _currentChair;

  void initCurrentChair() async {
    _currentChair = await ChairStore.getCurrentChair();
    notifyListeners();
  }

  Future setCurrentChair(Chair chair) async {
    print('set chair ${chair.uuid}');
    _currentChair = await ChairStore.setCurrentChair(chair);
    notifyListeners();
    return;
  }
}
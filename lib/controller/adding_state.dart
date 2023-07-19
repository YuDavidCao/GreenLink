import 'package:flutter/material.dart';

class AddingState extends ChangeNotifier {

  bool _onPosting = false;
  bool _onEditing = false;

  bool get onPosting => _onPosting;
  bool get onEditing => _onEditing;

  set onPosting(bool value) {
    _onPosting = value;
    notifyListeners();
  }

  set onEditing(bool value) {
    _onEditing = value;
    notifyListeners();
  }

  AddingState();

}
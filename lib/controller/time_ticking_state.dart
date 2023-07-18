import 'dart:async';

import 'package:flutter/material.dart';

class TimeTickingState extends ChangeNotifier {
  TimeTickingState() {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      notifyListeners();
    });
  }
}

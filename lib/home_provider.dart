import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int state) {
    _currentIndex = state;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class MyTheme extends ChangeNotifier {
  bool _isDark = false;

  bool get getTheme {
    return _isDark;
  }

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode getThemeMode() => _themeMode;

  void setTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}

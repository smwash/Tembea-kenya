import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPreferences _pref;

  ThemeProvider(this._pref);

  bool get isDarkMode => _pref?.getBool('darkTheme') ?? false;

  void setDarkMode(bool val) {
    _pref?.setBool('darkTheme', val);
    notifyListeners();
  }

  void switchDarkMode() {
    bool val = isDarkMode;
    if (isDarkMode)
      val = false;
    else
      val = true;
    _pref?.setBool('darkTheme', val);
    notifyListeners();
  }
}

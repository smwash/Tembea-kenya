import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _selectedTheme;
  SharedPreferences prefs;

  ThemeProvider({bool isDarkMode}) {
    _selectedTheme = isDarkMode ? darkTheme : lightTheme;
  }
  Future<void> setTheme() async {
    prefs = await SharedPreferences.getInstance();
    if (_selectedTheme == darkTheme) {
      _selectedTheme = lightTheme;
      await prefs.setBool('darkTheme', false);
    } else {
      _selectedTheme = darkTheme;
      await prefs.setBool('darkTheme', true);
    }
    notifyListeners();
  }

  ThemeData getTheme() => _selectedTheme;
}

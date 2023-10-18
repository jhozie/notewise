// import 'package:flutter/material.dart';
// import '../services/cloud/cloud_note.dart';

// class LatestListProvider extends ChangeNotifier {
//   List<CloudNote> _latestList = [];

//   List<CloudNote> get latestList => _latestList;

//   void addToLatestList(CloudNote note) {
//     _latestList.add(note);
//     notifyListeners();
//   }

//   void removeFromLatestList(int index) {
//     _latestList.removeAt(index);
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeType { light, dark }

class ThemeProvider extends ChangeNotifier {
  ThemeType _themeType = ThemeType.light;
  static const String _themeKey = 'theme';

  ThemeType get themeType => _themeType;

  ThemeProvider() {
    _loadTheme();
  }

  void toggleTheme() {
    _themeType =
        _themeType == ThemeType.light ? ThemeType.dark : ThemeType.light;
    _saveTheme();
    notifyListeners();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int themeIndex = prefs.getInt(_themeKey) ?? ThemeType.light.index;
    _themeType = ThemeType.values[themeIndex];
    notifyListeners();
  }

  void _saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_themeKey, _themeType.index);
  }
}

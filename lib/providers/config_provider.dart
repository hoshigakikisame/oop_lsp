import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/material.dart';

enum ConfigProviderState {
  initializing,
  ready,
}

class ConfigProvider with ChangeNotifier {
  late SharedPreferences _preferences;

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  ConfigProviderState _state = ConfigProviderState.initializing;
  ConfigProviderState get state => _state;

  ConfigProvider() {
    loadPreferences();
  }

  Color accentColor = primaryColor;

  Future<void> loadPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    await themePreference();
    _state = ConfigProviderState.ready;

    notifyListeners();
  }

  Future<void> themePreference() async {
    const String _keyTheme = 'isDarkTheme';
    if (_preferences.containsKey(_keyTheme)) {
      _themeMode =
          _preferences.getBool(_keyTheme)! ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void saveSettings() async {
    // SAVE THEME SETTING
    const String _keyTheme = 'isDarkTheme';
    if (_preferences.containsKey(_keyTheme)) _preferences.remove(_keyTheme);
    bool _isDark = _themeMode == ThemeMode.dark;
    _preferences.setBool(_keyTheme, _isDark);
  }

  void toggleThemeMode() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }

    saveSettings();
    notifyListeners();
  }
}

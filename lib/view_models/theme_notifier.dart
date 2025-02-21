import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// MVVM with Riverpod Implementation
final themeProvider = NotifierProvider<ThemeNotifier, bool>(ThemeNotifier.new);

class ThemeNotifier extends Notifier<bool> {
  static const String _themeKey = 'isDarkMode';
  late SharedPreferences _prefs;

  @override
  bool build() {
    _loadTheme();
    return false;
  }

  Future<void> _loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    state = _prefs.getBool(_themeKey) ?? false;
  }

  Future<void> toggleTheme() async {
    _prefs = await SharedPreferences.getInstance();
    state = !state;
    await _prefs.setBool(_themeKey, state);
  }
}

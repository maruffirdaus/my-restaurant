import 'package:shared_preferences/shared_preferences.dart';

import '../model/settings.dart';

class SharedPreferencesService {
  final SharedPreferences _prefs;
  static const String keyDailyReminderEnabled = 'DAILY_REMINDER_ENABLED';
  static const String keyDarkModeEnabled = 'DARK_MODE_ENABLED';

  SharedPreferencesService(this._prefs);

  Future<void> saveDailyReminderEnabled(bool isEnabled) async {
    try {
      await _prefs.setBool(keyDailyReminderEnabled, isEnabled);
    } catch (e) {
      throw Exception("Failed to save the change in SharedPreferences");
    }
  }

  Future<void> saveDarkModeEnabled(bool isEnabled) async {
    try {
      await _prefs.setBool(keyDarkModeEnabled, isEnabled);
    } catch (e) {
      throw Exception("Failed to save the change in SharedPreferences");
    }
  }

  Settings getSettings() {
    return Settings(
      dailyReminderEnabled: _prefs.getBool(keyDailyReminderEnabled) ?? false,
      darkModeEnabled: _prefs.getBool(keyDarkModeEnabled) ?? false,
    );
  }
}

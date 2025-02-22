import 'package:flutter/cupertino.dart';
import 'package:my_restaurant/data/model/settings.dart';
import 'package:my_restaurant/data/local/shared_preferences_service.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  final SharedPreferencesService _service;
  String? _message;
  String? get message => _message;
  Settings? _settings;
  Settings? get settings => _settings;

  SharedPreferencesProvider(this._service) {
    getSettings();
  }

  Future<void> saveDailyReminderEnabled(bool isEnabled) async {
    try {
      await _service.saveDailyReminderEnabled(isEnabled);
      _message = null;
    } catch (e) {
      _message = 'Failed to save the change';
    }

    notifyListeners();
  }

  Future<void> saveDarkModeEnabled(bool isEnabled) async {
    try {
      await _service.saveDarkModeEnabled(isEnabled);
      _message = null;
    } catch (e) {
      _message = 'Failed to save the change';
    }

    notifyListeners();
  }

  void getSettings() async {
    try {
      _settings = _service.getSettings();
      _message = null;
    } catch (e) {
      _message = 'Failed to retrieve settings data';
    }

    notifyListeners();
  }
}

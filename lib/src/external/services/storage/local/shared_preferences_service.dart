import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences _prefs;

  Future<void> initializeStorage() async =>
      _prefs = await SharedPreferences.getInstance();

  SharedPreferences get prefs => _prefs;

  Future<void> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  bool? getBool(String key) => _prefs.getBool(key);

  Future<void> setDouble(String key, double value) async =>
      await _prefs.setDouble(key, value);

  double? getDouble(String key) => _prefs.getDouble(key);

  Future<void> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);

  int? getInt(String key) => _prefs.getInt(key);

  Future<void> remove(String key) async => await _prefs.remove(key);

  bool? contains(String key) => _prefs.containsKey(key);

  Future<void> clear() async => await _prefs.clear();
}

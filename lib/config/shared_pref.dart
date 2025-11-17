import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  SharedPrefService._privateConstructor();
  static final SharedPrefService instance = SharedPrefService._privateConstructor();

  SharedPreferences? _prefs;

  // Initialize once in main()
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // String
  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  String getString(String key, [String defaultValue = '']) {
    return _prefs?.getString(key) ?? defaultValue;
  }

  // Int
  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  int getInt(String key, [int defaultValue = 0]) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  // Bool
  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  bool getBool(String key, [bool defaultValue = false]) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  // Remove
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  Future<void> clearAll() async {
    await _prefs?.clear();
  }
}

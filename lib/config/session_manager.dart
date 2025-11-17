import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  SessionManager._privateConstructor();
  static final SessionManager instance = SessionManager._privateConstructor();

  SharedPreferences? _prefs;

  /// Initialize once in main()
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// ----------------------
  /// Generic getters/setters
  /// ----------------------
  Future<void> setString(String key, String value) async => await _prefs?.setString(key, value);
  String getString(String key, [String defaultValue = '']) => _prefs?.getString(key) ?? defaultValue;

  Future<void> setInt(String key, int value) async => await _prefs?.setInt(key, value);
  int getInt(String key, [int defaultValue = 0]) => _prefs?.getInt(key) ?? defaultValue;

  Future<void> setBool(String key, bool value) async => await _prefs?.setBool(key, value);
  bool getBool(String key, [bool defaultValue = false]) => _prefs?.getBool(key) ?? defaultValue;

  Future<void> remove(String key) async => await _prefs?.remove(key);
  Future<void> clearAll() async => await _prefs?.clear();

  /// ----------------------
  /// Session-specific methods
  /// ----------------------

  // Token
  static const _keyToken = 'session_token';
  Future<void> setToken(String token) async => await setString(_keyToken, token);
  String getToken() => getString(_keyToken);

  // User ID
  static const _keyUserId = 'session_user_id';
  Future<void> setUserId(String userId) async => await setString(_keyUserId, userId);
  String getUserId() => getString(_keyUserId);

  // User Name
  static const _keyUserName = 'session_user_name';
  Future<void> setUserName(String name) async => await setString(_keyUserName, name);
  String getUserName() => getString(_keyUserName);

  // Login state
  static const _keyIsLoggedIn = 'session_is_logged_in';
  Future<void> setLoggedIn(bool loggedIn) async => await setBool(_keyIsLoggedIn, loggedIn);
  bool isLoggedIn() => getBool(_keyIsLoggedIn);

  // Example: Clear session on logout
  Future<void> clearSession() async {
    await remove(_keyToken);
    await remove(_keyUserId);
    await remove(_keyUserName);
    await setLoggedIn(false);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferencesManager? _instance;
  late SharedPreferences _preferences;

  SharedPreferencesManager._internal();

  static Future<SharedPreferencesManager> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesManager._internal();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setToken({required String apiToken}) async {
    await _preferences.setString('apiToken', apiToken);
  }

  Future<void> setProfile({required String profile}) async {
    await _preferences.setString('profile', profile);
  }

  Future<void> setName({required String name}) async {
    await _preferences.setString('name', name);
  }

  String? getProfile() {
    return _preferences.getString("profile");
  }

  String? getName() {
    return _preferences.getString("name");
  }

  String? getToken() {
    return _preferences.getString("apiToken");
  }

  Future<void> clearAll() async {
    await _preferences.clear();
  }
}

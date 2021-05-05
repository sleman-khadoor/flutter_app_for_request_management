import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPrefs _instance;
  SharedPreferences _prefs;

  SharedPrefs._createInstance();

  static Future<SharedPrefs> init() async {
    if (_instance == null) {
      _instance = SharedPrefs._createInstance();
      await _instance.getInstance();
      print("Constructr");
    }
    return _instance;
  }

  factory SharedPrefs() {
    if (_instance == null) {
      _instance = SharedPrefs._createInstance();
      _instance.getInstance();
    }
    return _instance;
  }

  Future<SharedPreferences> getInstance() async {
    if (_instance._prefs == null) {
      _instance._prefs = await SharedPreferences.getInstance();
    }
    return _instance._prefs;
  }

  void clear() {
    _instance._prefs.clear();
  }

  void logOut() {
    clear();
  }

  String getUserId() {
    return _instance._prefs.getString("userId");
  }

  String getUserName() {
    return _instance._prefs.getString("userName");
  }

  String getToken() {
    return _instance._prefs.getString("token");
  }

  void saveUserId(String userId) {
    _instance._prefs.setString("userId", userId);
  }

  void saveUserName(String userName) {
    _instance._prefs.setString("userName", userName);
  }

  void saveToken(String token) {
    _instance._prefs.setString("token", token);
  }

  void removeUserId() {
    _instance._prefs.remove("userId");
  }

  void removeUserName() {
    _instance._prefs.remove("userName");
  }

  void removeToken() {
    _instance._prefs.remove("token");
  }
}

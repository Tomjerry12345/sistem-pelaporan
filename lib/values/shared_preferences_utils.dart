import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<dynamic> get({type = "int", key = ""}) async {
    final SharedPreferences prefs = await _prefs;

    if (type == "int") {
      return prefs.getInt(key);
    } else if (type == "string") {
      return prefs.getString(key);
    }

    return null;
  }

  void set({type = "int", key = "", value}) async {
    final SharedPreferences prefs = await _prefs;

    if (type == "int") {
      prefs.setInt(key, value);
    } else if (type == "string") {
      prefs.setString(key, value);
    }
  }
}

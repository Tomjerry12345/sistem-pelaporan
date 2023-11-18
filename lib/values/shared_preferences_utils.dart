import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<dynamic>? get({key = ""}) async {
    final SharedPreferences prefs = await _prefs;

    final typePrefs = prefs.get(key);

    if (typePrefs is int) {
      return prefs.getInt(key);
    } else if (typePrefs is String) {
      return prefs.getString(key);
    } else {
      return null;
    }
  }

  static void set({key = "", value}) async {
    final SharedPreferences prefs = await _prefs;

    final typePrefs = key;

    if (typePrefs is int) {
      prefs.setInt(key, value);
    } else if (typePrefs is String) {
      prefs.setString(key, value);
    }
  }

  static void reset({key}) async {
    final SharedPreferences prefs = await _prefs;

    final typePrefs = prefs.get(key);

    if (typePrefs is int) {
      prefs.setInt(key, 0);
    } else if (typePrefs is String) {
      prefs.setString(key, "");
    }
  }
}

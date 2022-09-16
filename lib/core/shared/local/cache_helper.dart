import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? pref;

  static init() async => pref = await SharedPreferences.getInstance();

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async =>
      await pref!.setBool(key, value);

  static dynamic getData({
    required String key,
  }) =>
      pref!.get(key);

  static Future setData({
    required String key,
    required dynamic value,
  }) async =>
      await pref!.setString(key, value);

  static Future<dynamic> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await pref!.setString(key, value);
    if (value is int) return await pref!.setInt(key, value);
    if (value is bool) return await pref!.setBool(key, value);

    return await pref!.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async =>
      await pref!.remove(key);

  static Future<bool> setListOfData({
    required String key,
    required String id,
    required String role,
  }) async =>
      pref!.setStringList(key, [id, role]);

  static List<String>? getListOfData({
    required String key,
  }) =>
      pref!.getStringList(key);
}

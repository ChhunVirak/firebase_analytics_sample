// In this file, we write all the code needed to store and get data from the local storage using the plugin shared_preferences.
// In this file, there will be getters and setters for each and every data to be stored in the local storage.

import 'package:shared_preferences/shared_preferences.dart';

class LocalSorageService {
  late final SharedPreferences _pref;

  SharedPreferences get pref => _pref;

  LocalSorageService._();
  static final _instance = LocalSorageService._();
  factory LocalSorageService() => _instance;

  Future<void> initPrefs() async {
    _pref = await SharedPreferences.getInstance();
  }

  void getAny(String key) => _pref.get(key);

  String? getString(String key) => _pref.getString(key);

  bool? getBool(String key) => _pref.getBool(key);

  double? getDouble(String key) => _pref.getDouble(key);

  int? getInt(String key) => _pref.getInt(key);

  List<String>? getStringList(String key) => _pref.getStringList(key);

  Future<void> setString({
    required String key,
    required String value,
  }) async {
    await _pref.setString(key, value);
  }

  Future<void> setStringList({
    required String key,
    required List<String> value,
  }) async {
    await _pref.setStringList(key, value);
  }

  Future<void> setBool({
    required String key,
    required bool value,
  }) async {
    await _pref.setBool(key, value);
  }

  Future<void> setInt({
    required String key,
    required int value,
  }) async {
    await _pref.setInt(key, value);
  }

  Future<void> setDouble({
    required String key,
    required double value,
  }) async {
    await _pref.setDouble(key, value);
  }
}

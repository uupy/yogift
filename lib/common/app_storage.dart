import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// 应用存储
class AppStorage<T> {
  static SharedPreferences? _prefs;
  String keyName;

  AppStorage(this.keyName) : assert(keyName.isNotEmpty);

  Future<SharedPreferences> getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<T> get() async {
    SharedPreferences prefs = await getPrefs();
    // ignore: prefer_typing_uninitialized_variables
    var _value;
    if (<T>[] is List<String?>) {
      _value = prefs.getString(keyName);
    } else if (<T>[] is List<bool?>) {
      _value = prefs.getBool(keyName);
    } else if (<T>[] is List<int?>) {
      _value = prefs.getInt(keyName);
    } else if (<T>[] is List<double?>) {
      _value = prefs.getDouble(keyName);
    } else if (<T>[] is List<List<String>>) {
      _value = prefs.getStringList(keyName) ?? <String>[];
    } else {
      _value = prefs.getString(keyName);

      if (_value != null) {
        _value = json.decode(_value);
      } else if (_value == null && <T>[] is List<List>) {
        _value = <dynamic>[];
      }
    }
    return _value as T;
  }

  Future set(T value) async {
    SharedPreferences prefs = await getPrefs();
    if (value is String) {
      await prefs.setString(keyName, value);
    } else if (value is bool) {
      await prefs.setBool(keyName, value);
    } else if (value is int) {
      await prefs.setInt(keyName, value);
    } else if (value is double) {
      await prefs.setDouble(keyName, value);
    } else if (value is List<String>) {
      await prefs.setStringList(keyName, value);
    } else {
      await prefs.setString(keyName, json.encode(value));
    }
    return value;
  }

  Future<bool> remove() async {
    SharedPreferences prefs = await getPrefs();
    bool result = await prefs.remove(keyName);
    return result;
  }
}

/// 记录是否首次打开app
AppStorage<bool?> firstEntryApp = AppStorage('firstEntryApp');

/// 最新广告弹窗时间
AppStorage<int?> lastOpenAdTime = AppStorage('lastOpenAdTime');

/// 认证token
AppStorage<String?> accessToken = AppStorage('accessToken');

/// 认证data
AppStorage<Map<String, dynamic>?> authDataStorage = AppStorage('authData');

/// 登录用户信息
AppStorage<Map<String, dynamic>?> loginUser = AppStorage('loginUser');

/// 搜索历史
AppStorage<List<String>> searchHistory = AppStorage('searchHistory');

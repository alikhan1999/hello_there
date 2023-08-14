import 'dart:convert';

import 'package:empathyGenerator/model/local_user.dart';
import 'package:empathyGenerator/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefStorage implements IStorage {
  static final PrefStorage _instance = PrefStorage._internal();

  static PrefStorage get instance => _instance;

  factory PrefStorage() {
    return _instance;
  }
  PrefStorage._internal();

  static late SharedPreferences _prefs;

  static const _keyUser = 'userData';
  static const _keyBusinessProfile = 'businessProfile';
  static const _userToken = 'token';
  static const _rememberMe = 'RememberMe';

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> setUserToken(String token) =>
      _prefs.setString(_userToken, token);

  @override
  Future<void> allClear() => _prefs.clear();

  @override
  Future<bool> setUser(LocalUser user) =>
      _prefs.setString(_keyUser, jsonEncode(user.toJson()));

  @override
  LocalUser? get user {
    final userString = _prefs.getString(_keyUser);
    if (userString != null) {
      final userJson = jsonDecode(userString);
      return LocalUser.fromJson(userJson);
    }
    return null;
  }

  @override
  Future<bool> removeUser() => _prefs.remove(_keyUser);


  @override
  Future<bool> removeBusinessProfile() => _prefs.remove(_keyBusinessProfile);

  // void setRememberMe(bool loginCredential) =>
  //     _prefs.setBool(_rememberMe, loginCredential);
  // bool getRememberMe() => _prefs.getBool(_rememberMe) ?? false;
}

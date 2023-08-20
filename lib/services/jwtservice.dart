import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JwtServices {
  Future<bool> setJwt(String token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool setted = await pref.setString("token", token);
    return setted;
  }

  Future<String?> getJwt(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? getted = await pref.getString(key);
    if (getted != null) print(getted);
    return getted;
  }

  Future<bool> deleteKey(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool removed = await pref.remove(key);
    return removed;
  }
}

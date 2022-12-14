// import 'dart:convert';
//
// import 'package:get_storage/get_storage.dart';
//
//
// class Prefs {
//   late GetStorage _storage;
//
//   final String _USER_TOKEN_KEY = "userTokenKey";
//
//   Prefs() {
//     _storage = GetStorage();
//   }
//
//   Future<void> setUser(User user) async {
//     await _storage.remove(_USER_TOKEN_KEY);
//     return _storage.write(_USER_TOKEN_KEY, jsonEncode(user));
//   }
//
//   Future<User> getUser() async {
//     var user = _storage.read<String>(_USER_TOKEN_KEY) ?? "";
//     if (user.isNotEmpty) {
//       return User.fromJson(jsonDecode(user));
//     } else {
//       return User();
//     }
//   }
//
//   Future<void> clearToken() async {
//     return _storage.remove(_USER_TOKEN_KEY);
//   }
// }

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyToken = 'token';
  static const _keyUserName = 'userName';
  static const _keyUserSubscription = 'userSubscription';

  static Future setToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  static Future<String?> fetchToken() async {
    return await _storage.read(key: _keyToken);
  }

  static Future setUserName(String userName) async {
    await _storage.write(key: _keyUserName, value: userName);
  }

  static Future<String?> fetchUserName() async {
    return await _storage.read(key: _keyUserName);
  }

  static Future setUserSubscription(String subscription) async {
    await _storage.write(key: _keyUserSubscription, value: subscription);
  }

  static Future<String?> fetchUserSubscription() async {
    return await _storage.read(key: _keyUserSubscription);
  }

  static Future deleteSecureStorage() async {
    await _storage.deleteAll();
  }
}

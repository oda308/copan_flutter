import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api/register_user.dart';

class User {
  factory User() {
    _instance ??= User._internal();
    return _instance!;
  }

  User._internal();
  late final String token;
  // TODO(oda308): DBから取得するようにする
  final String name = 'TEST';
  // TODO(oda308): DBから取得するようにする
  bool isShared = true;
  static User? _instance;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final AndroidOptions _aOptions =
      const AndroidOptions(encryptedSharedPreferences: true);

  Future<void> init() async {
    final token = await readToken();
    if (token == null) {
      final token = await registerUser();
      await storeToken(token: token);
    }

    assert(() {
      debugPrint('token: $token');
      return true;
    }());

    _instance?.token = token!;
  }

  Future<String?> readToken() async =>
      _storage.read(key: 'token', aOptions: _aOptions);

  Future<void> storeToken({required String token}) async {
    await _storage.write(key: 'token', value: token, aOptions: _aOptions);
  }

  // TODO(oda308): Userをriverpodで管理して設定の変更でリビルドさせる
  Future<void> updateSharedSetting({required bool isShared}) async {
    this.isShared = isShared;
  }
}

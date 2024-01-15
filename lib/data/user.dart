import 'package:copan_flutter/data/api/register_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User {
  late final String token;
  // TODO: DBから取得するようにする
  final name = 'TEST';
  // TODO: DBから取得するようにする
  final isSharing = true;
  static User? _instance;
  final _storage = FlutterSecureStorage();
  final _aOptions = const AndroidOptions(encryptedSharedPreferences: true);

  factory User() {
    _instance ??= User._internal();
    return _instance!;
  }

  User._internal();

  Future<void> init() async {
    String? token = await readToken();
    if (token == null) {
      final token = await registerUser();
      await storeToken(token: token);
    }
    print('token: $token');
    _instance?.token = token!;
  }

  Future<String?> readToken() async {
    return _storage.read(key: 'token', aOptions: _aOptions);
  }

  Future<void> storeToken({required String token}) async {
    await _storage.write(key: 'token', value: token, aOptions: _aOptions);
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class User {
  late final String id;
  // TODO: DBから取得するようにする
  final name = 'TEST';
  static User? _instance;
  final _storage = FlutterSecureStorage();
  final _aOptions = const AndroidOptions(encryptedSharedPreferences: true);

  factory User() {
    _instance ??= User._internal();
    return _instance!;
  }

  User._internal();

  Future<void> init() async {
    String? id = await readId();
    if (id == null) {
      id = const Uuid().v4();
      await storeId(id: id);
    }
    _instance?.id = id;
  }

  Future<String?> readId() async {
    return _storage.read(key: 'id', aOptions: _aOptions);
  }

  Future<void> storeId({required String id}) async {
    await _storage.write(key: 'id', value: id, aOptions: _aOptions);
  }
}

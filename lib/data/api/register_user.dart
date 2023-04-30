import 'dart:async';

import '../../requester/requester.dart';

Future<String> registerUser(
    {required String name,
    required String email,
    required String password}) async {
  try {
    final requester = Requester.instance;
    if (requester == null) {
      return "";
    }
    // webサーバから取得
    return await requester.registerUserRequester(
        name: name, email: email, password: password);
  } catch (e) {
    rethrow;
  }
}

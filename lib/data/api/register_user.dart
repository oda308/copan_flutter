import 'dart:async';

import '../../requester/requester.dart';

Future<String> registerUser(
    {required String name,
    required String email,
    required String password}) async {
  try {
    final requester = Requester.instance;
    final accesstoken = await requester.registerUserRequester(
        name: name, email: email, password: password);
    return accesstoken;
  } catch (e) {
    rethrow;
  }
}

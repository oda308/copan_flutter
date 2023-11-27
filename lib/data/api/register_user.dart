import 'dart:async';

import '../../requester/requester.dart';

Future<String> registerUser() async {
  try {
    final requester = Requester.instance;
    final accesstoken = await requester.registerUserRequester();
    return accesstoken;
  } catch (e) {
    rethrow;
  }
}

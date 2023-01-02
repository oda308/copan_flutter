import 'dart:async';
import 'dart:convert';

import 'package:copan_flutter/main.dart';
import 'package:http/http.dart' as http;

Future<String> registerUser(
    {required String name,
    required String email,
    required String password}) async {
  try {
    // webサーバから取得
    return await _request(name: name, email: email, password: password);
  } catch (e) {
    rethrow;
  }
}

Future<String> _request(
    {required String name,
    required String email,
    required String password}) async {
  final req = <String, dynamic>{
    "action": "registerUser",
    "name": name,
    "email": email,
    "password": password
  };
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json.encode(req);

  try {
    http.Response resp = await http
        .post(Uri.parse(uri), headers: headers, body: body)
        .timeout(const Duration(seconds: 5));

    if (resp.statusCode != 200) {
      throw AssertionError("Failed get response");
    }

    final json = jsonDecode(resp.body) as Map<String, dynamic>;
    final token = json["access_token"] as String;

    return token;
  } on TimeoutException catch (_) {
    throw AssertionError("A timeout occured.");
  } catch (e) {
    rethrow;
  }
}

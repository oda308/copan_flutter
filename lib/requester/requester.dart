import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Requester {
  String uri = defaultTargetPlatform == TargetPlatform.android
      ? "http://10.0.2.2:5500"
      : "http://10.0.2.2:5500";

  Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  Requester();

  Future<bool> loginRequester(String email, String password) async {
    final loginUri = "$uri/auth/login";
    final request = AuthRequest(email: email, password: password);
    final response = await http.post(Uri.parse(loginUri),
        body: json.encode(request.toJson()), headers: headers);

    if (response.statusCode == 200) {
      // レスポンスで取得したjsonをmapに格納
      Map<String, dynamic> decoded = json.decode(response.body);
      final loginResponse = AuthResponse.fromJson(decoded);
      debugPrint(loginResponse.accessToken);
      // TODO: どこかに保存する処理
      return true;
    } else {
      return false;
    }
  }

  Future<void> logoutRequester() async {
    final logoutUri = "${uri}auth/logout";
    // アクセストークンはヘッダーに含める。今回は空
    headers['Authorization'] = "";

    final response = await http.post(Uri.parse(logoutUri), headers: headers);

    // これなんで201??
    if (response.statusCode == 201) {
      print("ログアウト時に実行する処理");
    }
  }
}

class AuthRequest {
  final String email;
  final String password;

  AuthRequest({
    this.email = "",
    this.password = "",
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class AuthResponse {
  final String accessToken;

  // リダイレクトコンストラクタ。あらかじめ定義したコンストラクタを使用できる
  AuthResponse.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'];
}

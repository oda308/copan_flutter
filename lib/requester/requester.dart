import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config/base_url.dart';
import '../data/user.dart';

class Requester {
  static Requester instance = Requester();

  Map<String, String> header({required bool needsAccessToken}) {
    late Map<String, String> header;

    header = <String, String>{
      'Content-Type': 'application/json',
    };

    if (needsAccessToken) {
      header['Authorization'] = User().token;
    }

    return header;
  }

  Future<List<Map<String, dynamic>>> allExpensesRequester() async {
    final req = <String, dynamic>{
      'action': 'getAllExpenses',
    };
    final body = json.encode(req);
    late List<Map<String, dynamic>> expenses;

    try {
      final resp = await http
          .post(
            Uri.parse(BaseUrl.url),
            headers: header(needsAccessToken: true),
            body: body,
          )
          .timeout(const Duration(seconds: 5));

      if (resp.statusCode != 200) {
        throw AssertionError('Failed get response');
      }
      // TODO(oda308): jsonDecodeを2回使用しないとlistではなくstringが返ってくる
      // https://stackoverflow.com/questions/73511236/flutter-jsondecode-returns-string-instead-of-list
      expenses = jsonDecode(jsonDecode(resp.body) as String)
          as List<Map<String, dynamic>>;
    } on TimeoutException catch (_) {
      throw AssertionError('A timeout occured.');
    }
    return expenses;
  }

  Future<String> registerUserRequester() async {
    final req = <String, dynamic>{'action': 'registerUser'};
    final body = json.encode(req);

    try {
      final resp = await http
          .post(
            Uri.parse('${BaseUrl.url}/registerUser'),
            headers: header(needsAccessToken: false),
            body: body,
          )
          .timeout(const Duration(seconds: 5));

      if (resp.statusCode != 200) {
        throw AssertionError('Failed get response');
      }

      final json = jsonDecode(resp.body) as Map<String, dynamic>;
      final token = json['access_token'] as String;

      return token;
    } on TimeoutException catch (_) {
      throw AssertionError('A timeout occured.');
    }
  }

  Future<void> inputExpenseRequester({
    required int price,
    required int categoryId,
    required String description,
    required DateTime date,
    required String expenseUuid,
  }) async {
    final expense = <String, dynamic>{
      'action': 'insertExpense',
      'price': price,
      'categoryId': categoryId,
      'description': description,
      'date': date.toString(),
      'expenseUuid': expenseUuid,
    };
    final body = json.encode(expense);

    final resp = await http.post(
      Uri.parse(BaseUrl.url),
      headers: header(needsAccessToken: true),
      body: body,
    );

    if (resp.statusCode != 200) {
      throw AssertionError('Failed get response');
    }

    assert(() {
      debugPrint(resp as String);
      return true;
    }());
  }

  Future<void> deleteExpenseRequester({
    required String expenseUuid,
  }) async {
    final req = <String, dynamic>{
      'action': 'deleteExpense',
      'expenseUuid': expenseUuid,
    };
    final body = json.encode(req);

    final resp = await http.post(
      Uri.parse(BaseUrl.url),
      headers: header(needsAccessToken: true),
      body: body,
    );

    if (resp.statusCode != 200) {
      throw AssertionError('Failed get response');
    }
  }
}

class AuthRequest {
  AuthRequest({
    this.email = '',
    this.password = '',
  });
  final String email;
  final String password;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'email': email,
        'password': password,
      };
}

class AuthResponse {
  AuthResponse.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'] as String;
  final String accessToken;
}

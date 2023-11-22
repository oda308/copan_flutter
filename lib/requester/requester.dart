import 'dart:async';
import 'dart:convert';

import 'package:copan_flutter/main.dart';
import 'package:http/http.dart' as http;

class Requester {
  String? accessToken;

  static Requester instance = Requester();

  Map<String, String> header({required bool needsAccessToken}) {
    late Map<String, String> header;

    header = {
      "Content-Type": "application/json",
    };

    if (needsAccessToken && accessToken != null) {
      header["Authorization"] = accessToken!;
    }

    return header;
  }

  Future<List<dynamic>> allExpensesRequester() async {
    final req = <String, dynamic>{
      "action": "getAllExpenses",
    };
    String body = json.encode(req);
    late List<dynamic> expenses;

    try {
      http.Response resp = await http
          .post(Uri.parse(uri),
              headers: header(needsAccessToken: true), body: body)
          .timeout(const Duration(seconds: 5));

      if (resp.statusCode != 200) {
        throw AssertionError("Failed get response");
      }
      // TODO: jsonDecodeを2回使用しないとlistではなくstringが返ってくる
      // https://stackoverflow.com/questions/73511236/flutter-jsondecode-returns-string-instead-of-list
      expenses = jsonDecode(jsonDecode(resp.body) as String) as List<dynamic>;
    } on TimeoutException catch (_) {
      throw AssertionError("A timeout occured.");
    } catch (e) {
      expenses = [];
      rethrow;
    }
    return expenses;
  }

  Future<String> registerUserRequester(
      {required String name,
      required String email,
      required String password}) async {
    final req = <String, dynamic>{
      "action": "registerUser",
      "name": name,
      "email": email,
      "password": password
    };
    String body = json.encode(req);

    try {
      http.Response resp = await http
          .post(Uri.parse(uri),
              headers: header(needsAccessToken: false), body: body)
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

  void inputExpenseRequester({
    required int price,
    required int categoryId,
    required String description,
    required DateTime date,
    required String expenseUuid,
  }) async {
    final expense = <String, dynamic>{
      "action": "insertExpense",
      "price": price,
      "categoryId": categoryId,
      "description": description,
      "date": date.toString(),
      "expenseUuid": expenseUuid,
    };
    String body = json.encode(expense);

    http.Response resp = await http.post(Uri.parse(uri),
        headers: header(needsAccessToken: true), body: body);

    if (resp.statusCode != 200) {
      throw AssertionError("Failed get response");
    }

    print(resp);
  }

  Future<void> deleteExpenseRequester({
    required String expenseUuid,
  }) async {
    final req = <String, dynamic>{
      "action": "deleteExpense",
      "expenseUuid": expenseUuid,
    };
    String body = json.encode(req);
    try {
      http.Response resp = await http.post(Uri.parse(uri),
          headers: header(needsAccessToken: true), body: body);

      if (resp.statusCode != 200) {
        throw AssertionError("Failed get response");
      }
    } catch (e) {
      rethrow;
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

  AuthResponse.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'] as String;
}

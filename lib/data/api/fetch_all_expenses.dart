import 'dart:async';
import 'dart:convert';

import 'package:copan_flutter/data/expense/expense.dart';
import 'package:copan_flutter/main.dart';
import 'package:http/http.dart' as http;

Future<List<Expense>> fetchAllExpenses() async {
  late final List<Expense> expenses;
  try {
    // webサーバから取得
    final expensesFromWeb = await _request(userId: 1);
    expenses = convertWebAPIToExpenses(expensesFromWeb);

    // ToDo: 同期で持ってきたデータとローカルDBのデータの取り扱い
    //final expenses =
    //    convertExpensesTableToExpenses(await db.copanDB.getAllExpenseEntries);
  } catch (e) {
    expenses = [];
    rethrow;
  }

  return expenses;
}

Future<List<dynamic>> _request({
  required int userId,
}) async {
  final req = <String, dynamic>{
    "action": "getAllExpenses",
    "userId": userId,
  };
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json.encode(req);
  late List<dynamic> expenses;

  try {
    http.Response resp = await http
        .post(Uri.parse(uri), headers: headers, body: body)
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

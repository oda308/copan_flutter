import 'package:copan_flutter/data/api/fetch_all_expenses.dart';
import 'package:copan_flutter/data/user.dart';
import 'package:copan_flutter/main.dart';
import 'package:copan_flutter/requester/requester.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/db/dao.dart' as db;

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
          image: const AssetImage('assets/images/login.jpg'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [_Title(), _LoginForm(), SizedBox.shrink()],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64.0),
      child: Column(
        children: const [
          Text(
            "Copan",
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600),
          ),
          Text(
            "家族で共有する家計簿",
            style: TextStyle(
                color: Color.fromARGB(255, 234, 234, 234),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _LoginForm extends ConsumerStatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<_LoginForm> {
  bool failedLogin = false;

  @override
  Widget build(BuildContext context) {
    String inputId = "";
    String inputPassword = "";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
            child: Column(
              children: [
                failedLogin
                    ? const Text(
                        "ログイン情報に誤りがあります",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    : const SizedBox.shrink(),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      hintText: "メールアドレス",
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 110, 110, 110),
                      )),
                  onChanged: (value) {
                    inputId = value;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      hintText: "パスワード",
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 110, 110, 110),
                      )),
                  onChanged: (value) {
                    inputPassword = value;
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  fixedSize: const Size.fromWidth(double.maxFinite)),
              onPressed: () async {
                final email = inputId;
                final password = inputPassword;

                final accessToken =
                    await Requester().loginRequester(email, password);

                if (accessToken != null) {
                  db.copanDB.addUser(db.UsersTableCompanion(
                    email: drift.Value(email),
                    accessToken: drift.Value(accessToken),
                  ));

                  user = User(email, accessToken);

                  final expenses = await fetchAllExpenses();
                  ref.read(expensesProvider.notifier).initExpenses(expenses);
                  if (!mounted) return;
                  await Navigator.of(context).pushReplacementNamed('/home');
                } else {
                  setState(() {
                    failedLogin = true;
                  });
                }
              },
              child: const Text('ログイン'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  fixedSize: const Size.fromWidth(double.maxFinite)),
              onPressed: () => Navigator.of(context).pushNamed('/signUp'),
              child: const Text('アカウント登録'),
            ),
          ),
        ],
      ),
    );
  }
}

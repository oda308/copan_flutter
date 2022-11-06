import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

import '../../data/local/db/dao.dart' as db;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final inputFields = _InputFields();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('アカウントの作成'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'お名前',
                  ),
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    setState(() {
                      inputFields.name = value;
                    });
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'メールアドレス',
                  ),
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    setState(() {
                      inputFields.email = value;
                    });
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'パスワードを入力',
                  ),
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    setState(() {
                      inputFields.password = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'パスワードを確認',
                      errorText: inputFields.errorPassword),
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    setState(() {
                      inputFields.confirmPassword = value;
                    });
                  },
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 24)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  fixedSize: const Size.fromWidth(double.maxFinite)),
              onPressed: _isCompletedForm(inputFields)
                  ? () async {
                      if (inputFields.password == inputFields.confirmPassword) {
                        // userセット
                        db.copanDB.addUser(db.UsersTableCompanion(
                          email: drift.Value("test"),
                          accessToken: drift.Value("test"),
                          // TODO: サーバから取得したアクセストークンを追加する
                        ));
                        // TODO: アクセストークンを取得したらページ遷移

                        await Navigator.of(context)
                            .pushNamed('/signUpCompleted');
                      } else {
                        setState(() {
                          inputFields.errorPassword = inputFields.password ==
                                  inputFields.confirmPassword
                              ? null
                              : 'パスワードが一致しません';
                        });
                      }
                    }
                  : null,
              child: const Text('アカウントの作成'),
            ),
          ],
        ),
      ),
    );
  }

  bool _isCompletedForm(_InputFields inputFields) {
    if (inputFields.name.isEmpty ||
        inputFields.email.isEmpty ||
        inputFields.password.isEmpty ||
        inputFields.confirmPassword.isEmpty) {
      return false;
    }
    return true;
  }
}

class _InputFields {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String errorName = '';
  String errorEmail = '';
  String? errorPassword;
}

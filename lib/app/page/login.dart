import 'package:flutter/material.dart';

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _Title(),
              const _LoginForm(),
              Container(
                color: Colors.blue,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamed('/signUp'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      fixedSize: const Size.fromWidth(double.maxFinite),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero))),
                  child: const Text(
                    'アカウント登録',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
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

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
            child: Column(
              children: [
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
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/home'),
              child: const Text('ログイン'),
            ),
          ),
        ],
      ),
    );
  }
}

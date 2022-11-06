import 'package:flutter/material.dart';

class SignUpCompleted extends StatelessWidget {
  const SignUpCompleted({Key? key}) : super(key: key);

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
            Text("アカウントの作成が完了しました"),
            Padding(padding: EdgeInsets.only(bottom: 24)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  fixedSize: const Size.fromWidth(double.maxFinite)),
              onPressed: () async {
                print("家計簿に進む");
                await Navigator.of(context).pushReplacementNamed('/home');
              },
              child: const Text('家計簿に進む'),
            ),
          ],
        ),
      ),
    );
  }
}

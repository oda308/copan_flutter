import 'package:copan_flutter/utility/l10n.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Sharing extends StatelessWidget {
  const Sharing({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.shared_budget),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Text("共有する人の端末でコードを読み取ってください"),
                const SizedBox(height: 16),
                QrImageView(
                  data: '1234567890',
                  version: QrVersions.auto,
                  size: 200.0,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      print("update_qr");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.refresh),
                        SizedBox(width: 8),
                        Text('更新'),
                      ],
                    )),
                SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/scanner');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.qr_code),
                        SizedBox(width: 8),
                        Text('読み取る'),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

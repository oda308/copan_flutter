import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../utility/l10n.dart';

class Sharing extends StatelessWidget {
  const Sharing({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(l10n.shared_budget),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                const Text('共有する人の端末でコードを読み取ってください'),
                const SizedBox(height: 16),
                QrImageView(
                  data: '1234567890',
                  size: 200,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    assert(() {
                      debugPrint('update_qr');
                      return true;
                    }());
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.refresh),
                      SizedBox(width: 8),
                      Text('更新'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).pushNamed('/scanner');
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.qr_code),
                      SizedBox(width: 8),
                      Text('読み取る'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

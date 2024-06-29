import 'package:flutter/material.dart';

import '../../utility/l10n.dart';

class PaymentRatio extends StatelessWidget {
  const PaymentRatio({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.payment_ratio),
      ),
      body: SafeArea(
        bottom: false,
        child: Center(
          child: Text(l10n.payment_ratio),
        ),
      ),
    );
  }
}

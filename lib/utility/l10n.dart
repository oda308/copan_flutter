import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

L10n useL10n(BuildContext context) {
  final l10n = L10n.of(context)!;
  return l10n;
}

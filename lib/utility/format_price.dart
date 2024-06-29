import 'package:intl/intl.dart';

String getFormattedPrice(int priceString) {
  final f = NumberFormat(',###');
  return f.format(priceString);
}

import 'package:intl/intl.dart';

String getFormattedPrice(int priceString) {
  var f = NumberFormat(",###");
  return f.format(priceString);
}

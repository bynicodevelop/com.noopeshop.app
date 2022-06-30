import 'package:intl/intl.dart';

String currenryFormatter(
  int value,
) {
  return NumberFormat.currency(
    locale: "fr_FR",
    symbol: "€",
  ).format(
    value / 100,
  );
}

import 'package:com_noopeshop_app/utils/currency_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return 0,00 €', () {
    expect(currenryFormatter(0), "0,00 €");
  });
  test('Should return 10,00 €', () {
    expect(currenryFormatter(1000), "10,00 €");
  });

  test('Should return 12,23 €', () {
    expect(currenryFormatter(1223), "12,23 €");
  });
}

import 'package:com_noopeshop_app/utils/math_sum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("calculateSumPrice", () {
    test('Should return 0', () {
      expect(calculateSumPrice([]), 0);
    });

    test('Should return 1000 with quantity 1', () {
      expect(
          calculateSumPrice([
            {
              "varianteModel": {
                "price": 1000,
              },
              "quantity": 1,
            },
          ]),
          1000);
    });

    test('Should return 1000 with quantity 2', () {
      expect(
          calculateSumPrice([
            {
              "varianteModel": {
                "price": 500,
              },
              "quantity": 2,
            },
          ]),
          1000);
    });
  });

  group("calculateSumTax", () {
    test('Should return 0', () {
      expect(calculateSumTax([]), 0);
    });

    test('Should return 1000 with quantity 1', () {
      expect(
          calculateSumTax([
            {
              "varianteModel": {
                "tax": 1000,
              },
              "quantity": 1,
            },
          ]),
          1000);
    });

    test('Should return 1000 with quantity 2', () {
      expect(
          calculateSumTax([
            {
              "varianteModel": {
                "tax": 500,
              },
              "quantity": 2,
            },
          ]),
          1000);
    });
  });
}

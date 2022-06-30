import 'package:com_noopeshop_app/utils/validate_expiry_date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("validateExpiryDate", () {
    test('Should return true', () {
      String month = DateTime.now().month.toString();

      if (month.toString().length == 1) {
        month = "0$month";
      }

      String year = DateTime.now().year.toString().substring(2, 4);

      if (year.toString().length == 1) {
        year = "0$year";
      }

      String date = "$month$year";

      expect(validateExpiryDate(date, DateTime.now()), true);
    });

    test('Should return true', () {
      String month = (DateTime.now().month + 1).toString();

      if (month.toString().length == 1) {
        month = "0$month";
      }

      String year = DateTime.now().year.toString().substring(2, 4);

      if (year.toString().length == 1) {
        year = "0$year";
      }

      String date = "$month$year";

      expect(validateExpiryDate(date, DateTime.now()), true);
    });

    test('Should return false', () {
      String month = (DateTime.now().month + 1).toString();

      if (month.toString().length == 1) {
        month = "0$month";
      }

      String year = (DateTime.now().year - 1).toString();

      if (year.toString().length == 1) {
        year = "0$year";
      }

      String date = "$month$year";

      expect(validateExpiryDate(date, DateTime.now()), false);
    });
  });
}

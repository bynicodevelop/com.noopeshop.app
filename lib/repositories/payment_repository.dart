import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:com_noopeshop_app/exceptions/payment_exception.dart';

class PaymentRepository {
  final FirebaseFunctions firebaseFunctions;

  const PaymentRepository({
    required this.firebaseFunctions,
  });

  Future<void> intentPayment(Map<String, dynamic> data) async {
    // TODO: try catch

    final int price = data["carts"].fold(
      0,
      (previousValue, element) =>
          previousValue +
          int.parse(element["varianteModel"]["price"].toString()) *
              int.parse(
                element["quantity"].toString(),
              ),
    );

    final int tax = data["carts"].fold(
      0,
      (previousValue, element) =>
          previousValue +
          int.parse(0.toString()) *
              int.parse(
                element["quantity"].toString(),
              ),
    );

    final Map<String, dynamic> params = {
      "billingDetails": {
        "name": data["name"],
        "email": data["email"],
        "shipping": {
          "address": data["shippingAddress"],
          "city": data["shippingCity"],
          "state": "Fr",
          "postal_code": data["shippingPostalCode"],
          "country": "France",
        }
      },
      "card": {
        "number": data["cardNumber"],
        // "number": "4000000000000002",
        "expiration": data["cardExpiry"],
        "cvc": data["cardCvv"],
      },
      "order": {
        // TODO: Si internationnal, mettre la devise
        "currency": "eur",
        "amount": price + tax,
      },
    };

    HttpsCallableResult httpsCallable =
        await firebaseFunctions.httpsCallable("onIntentPayment").call(params);

    log(httpsCallable.data.toString());

    if (!httpsCallable.data["success"]) {
      throw PaymentException(
        code: PaymentException.invalidCard,
      );
    }
  }
}

class PaymentException implements Exception {
  static const String invalidCard = "invalidCard";

  final String code;

  PaymentException({
    required this.code,
  });
}

class AuthenticationException implements Exception {
  static const String unauthorized = 'Unauthorized';

  final String code;

  AuthenticationException({
    required this.code,
  });
}

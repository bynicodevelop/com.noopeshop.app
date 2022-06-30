import 'package:com_noopeshop_app/exceptions/authentication_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepositoryAbstract {
  final FirebaseAuth firebaseAuth;

  AuthenticationRepositoryAbstract({
    required this.firebaseAuth,
  });

  User getUser() {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw AuthenticationException(
        code: AuthenticationException.unauthorized,
      );
    }

    return user;
  }
}

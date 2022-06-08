import 'package:com_noopeshop_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  final FirebaseAuth firebaseAuth;

  const AuthenticationRepository({
    required this.firebaseAuth,
  });

  Stream<UserModel> get user {
    return firebaseAuth.authStateChanges().map((user) {
      if (user == null) {
        return UserModel.empty();
      }

      return UserModel.fromJson({
        'uid': user.uid,
      });
    });
  }

  // TODO: Ajouter try catch
  Future<UserModel> authenticateAnonymously() async {
    final UserCredential userCredential =
        await firebaseAuth.signInAnonymously();

    return UserModel.fromJson({
      'uid': userCredential.user!.uid,
    });
  }
}

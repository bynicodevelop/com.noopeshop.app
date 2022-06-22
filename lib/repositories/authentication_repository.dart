import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_noopeshop_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthenticationRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseMessaging messaging;

  const AuthenticationRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.messaging,
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

  Stream<RemoteMessage> get notifications =>
      FirebaseMessaging.onMessageOpenedApp.map((RemoteMessage event) {
        print(event.messageId);
        print(event.data);
        print(event);
        return event;
      });

  // TODO: Ajouter try catch
  Future<UserModel> authenticateAnonymously() async {
    final UserCredential userCredential =
        await firebaseAuth.signInAnonymously();

    return UserModel.fromJson({
      'uid': userCredential.user!.uid,
    });
  }

  Future<void> updateNotificationToken() async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      return;
    }

    NotificationSettings settings = await messaging.getNotificationSettings();

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }

    final String? token = await messaging.getToken();

    DocumentSnapshot<Map<String, dynamic>> userDocumentSnapshot =
        await firebaseFirestore.collection('users').doc(user.uid).get();

    if (userDocumentSnapshot.exists) {
      await firebaseFirestore.collection('users').doc(user.uid).update({
        'notificationToken': token,
      });
    } else {
      await firebaseFirestore.collection('users').doc(user.uid).set({
        'notificationToken': token,
      });
    }
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_noopeshop_app/models/user_model.dart';
import 'package:com_noopeshop_app/repositories/abstracts/authentication_repository_abstract.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthenticationRepository extends AuthenticationRepositoryAbstract {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseMessaging messaging;

  AuthenticationRepository({
    required this.firebaseFirestore,
    required this.messaging,
    required FirebaseAuth firebaseAuth,
  }) : super(
          firebaseAuth: firebaseAuth,
        );

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
        return event;
      });

  Future<UserModel> authenticateAnonymously() async {
    try {
      log('AuthenticationRepository.authenticateAnonymously: Creating new authentication');
      final UserCredential userCredential =
          await firebaseAuth.signInAnonymously();

      return UserModel.fromJson({
        'uid': userCredential.user!.uid,
      });
    } on FirebaseException catch (e) {
      log("AuthenticationRepository.authenticateAnonymously: ${e.code} - ${e.message}");

      return UserModel.empty();
    }
  }

  Future<void> updateNotificationToken() async {
    log('AuthenticationRepository.updateNotificationToken: Updating notification token');

    final User user = getUser();

    NotificationSettings settings = await messaging.getNotificationSettings();

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      log('AuthenticationRepository.updateNotificationToken: Notification permission denied');
      return;
    }

    try {
      final String? token = await messaging.getToken();

      if (token != null) {
        await _saveTokenInFirestore(
          token,
          user.uid,
        );
      }
    } catch (e) {
      log('AuthenticationRepository.updateNotificationToken: ${e.toString()}');
    }
  }

  Future<void> _saveTokenInFirestore(String token, String userId) async {
    DocumentReference<Map<String, dynamic>> reference =
        firebaseFirestore.collection('users').doc(userId);

    DocumentSnapshot<Map<String, dynamic>> userDocumentSnapshot =
        await reference.get();

    final Map<String, dynamic> data = {
      'notificationToken': token,
    };

    if (userDocumentSnapshot.exists) {
      await reference.update(data);
    } else {
      await reference.set(data);
    }
  }
}

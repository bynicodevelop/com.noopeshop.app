import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum FavoriteStatusEnum {
  liked,
  unliked,
}

class FavoriteRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  final StreamController<List<ProductModel>> _favoritesController =
      StreamController.broadcast();

  Stream<List<ProductModel>> get favorites => _favoritesController.stream;

  FavoriteRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  Future<void> loadFavorites() async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }
    print(user.uid);
    firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .collection("favorites")
        .snapshots()
        .listen((snapshot) async {
      final List<ProductModel> favorites = (await Future.wait(
        snapshot.docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> favorite) async {
          final DocumentSnapshot<Map<String, dynamic>> productDocumentSnapshot =
              await firebaseFirestore
                  .collection("products")
                  .doc(favorite.id)
                  .get();

          return ProductModel.fromJson({
            "id": productDocumentSnapshot.id,
            "reference": productDocumentSnapshot.reference,
            ...productDocumentSnapshot.data()!,
            "isFavorite": true,
          });
        }),
      ))
          .toList();

      _favoritesController.add(favorites);
    });
  }

  Future<FavoriteStatusEnum> toggleFavorite(Map<String, dynamic> data) async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    final DocumentReference userRef =
        firebaseFirestore.collection("users").doc(user.uid);

    DocumentSnapshot<Map<String, dynamic>> productDocumentSnapshot =
        await userRef.collection("favorites").doc(data['id']).get();

    if (productDocumentSnapshot.exists) {
      await userRef.collection("favorites").doc(data['id']).delete();

      return FavoriteStatusEnum.unliked;
    } else {
      await userRef.collection("favorites").doc(data['id']).set({
        "productRef": data['reference'],
      });

      return FavoriteStatusEnum.liked;
    }
  }
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

enum FavoriteStatusEnum {
  liked,
  unliked,
}

class FavoriteRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  final StreamController<List<ProductModel>> _favoritesController =
      StreamController.broadcast();

  Stream<List<ProductModel>> get favorites => _favoritesController.stream;

  FavoriteRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  Future<void> loadFavorites() async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .collection("favorites")
        .orderBy(
          "createdAt",
          descending: true,
        )
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

          final List<dynamic> media = productDocumentSnapshot.data()!['media'];

          final List<String> mediaUrls = await Future.wait(
            media.map(
              (mediaUrl) async =>
                  await firebaseStorage.ref().child(mediaUrl).getDownloadURL(),
            ),
          );

          return ProductModel.fromJson({
            "id": productDocumentSnapshot.id,
            "reference": productDocumentSnapshot.reference,
            ...productDocumentSnapshot.data()!,
            "media": mediaUrls,
            "mediaType": "MediaTypeEnum.image",
            "isFavorite": true,
          });
        }),
      ))
          .toList();

      _favoritesController.add(favorites);
    });
  }

  Future<ProductModel> toggleFavorite(Map<String, dynamic> data) async {
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

      return ProductModel.fromJson({
        ...data,
        "mediaType": data['mediaType'].toString(),
        "isFavorite": false,
      });
    } else {
      await userRef.collection("favorites").doc(data['id']).set({
        "productRef": data['reference'],
      });

      return ProductModel.fromJson({
        ...data,
        "mediaType": data['mediaType'].toString(),
        "isFavorite": true,
      });
    }
  }

  Stream<ProductModel> getProductModel(Map<String, dynamic> data) {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    return firebaseFirestore
        .collection("products")
        .doc(data["id"])
        .snapshots()
        .asyncMap(
      (snapshot) async {
        final DocumentSnapshot<Map<String, dynamic>> favoriteDocumentSnapshot =
            await firebaseFirestore
                .collection("users")
                .doc(user.uid)
                .collection("favorites")
                .doc(snapshot.id)
                .get();

        final QuerySnapshot<Map<String, dynamic>> variantesQuerySnapshot =
            await firebaseFirestore
                .collection('products')
                .doc(snapshot.id)
                .collection("variantes")
                .get();

        final List<dynamic> media = [
          ...snapshot.data()!['media'],
          ...variantesQuerySnapshot.docs
              .map((variante) => variante.data()["media"])
              .toList()
              .expand((element) => element)
              .toList()
        ];

        final List<String> mediaUrls = await Future.wait(
          media.map(
            (mediaUrl) async =>
                await firebaseStorage.ref().child(mediaUrl).getDownloadURL(),
          ),
        );

        return ProductModel.fromJson({
          "id": snapshot.id,
          "reference": snapshot.reference,
          ...snapshot.data()!,
          "media": mediaUrls,
          "mediaType": "MediaTypeEnum.image",
          "isFavorite": favoriteDocumentSnapshot.exists,
        });
      },
    );
  }
}

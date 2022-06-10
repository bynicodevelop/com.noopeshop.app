import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

const List<Map<String, dynamic>> products = [
  {
    "id": "1",
    "title": "Body Lotion - Fitness extreme",
    "description": "This is a product description",
    "media": "assets/samples/1.png",
    "mediaType": "MediaTypeEnum.image",
  },
  {
    "id": "1",
    "title": "Product 2",
    "description": "This is a product description",
    "media": "assets/samples/2.png",
    "mediaType": "MediaTypeEnum.image",
  },
  {
    "id": "1",
    "title": "Product 3",
    "description": "This is a product description",
    "media": "assets/samples/3.png",
    "mediaType": "MediaTypeEnum.image",
  },
  {
    "id": "1",
    "title": "Product 3",
    "description": "This is a product description",
    "media": "assets/samples/4.mp4",
    "mediaType": "MediaTypeEnum.video",
  },
];

class FeedRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  final int _limit = 2;

  QueryDocumentSnapshot<Map<String, dynamic>>? _lastVisible;

  final List<ProductModel> _feeds = [];

  FeedRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  Future<List<ProductModel>> getFeed(int index) async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception("User is not logged in");
    }

    if (index != 0 && (index + 1) < _feeds.length) {
      return _feeds;
    }

    late QuerySnapshot<Map<String, dynamic>> querySnapshot;

    Query<Map<String, dynamic>> query =
        firebaseFirestore.collection('products').orderBy(
              'createdAt',
              descending: true,
            );

    if (_lastVisible != null) {
      query = query.startAfterDocument(_lastVisible!);
    }

    querySnapshot = await query.limit(_limit).get();

    if (querySnapshot.docs.isEmpty) {
      return _feeds;
    }

    _lastVisible = querySnapshot.docs.last;

    _feeds.addAll(
      await Future.wait(querySnapshot.docs.map(
        (product) async {
          final String media = product.data()['media'];

          final String mediaUrl =
              await firebaseStorage.ref().child(media).getDownloadURL();

          DocumentSnapshot<Map<String, dynamic>> favoriteDocumentSnapshot =
              await firebaseFirestore
                  .collection("users")
                  .doc(user.uid)
                  .collection("favorites")
                  .doc(product.id)
                  .get();

          return ProductModel.fromJson({
            "id": product.id,
            "reference": product.reference,
            ...product.data(),
            "media": mediaUrl,
            "isFavorite": favoriteDocumentSnapshot.exists,
          });
        },
      )),
    );

    return _feeds;
  }
}

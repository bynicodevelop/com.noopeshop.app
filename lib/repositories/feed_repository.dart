import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:com_noopeshop_app/models/option_model.dart';
import 'package:com_noopeshop_app/models/variante_model.dart';
import 'package:com_noopeshop_app/repositories/abstracts/options_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FeedRepository extends OptionsRepositoryAbstract {
  final FirebaseFirestore firebaseFirestore;

  final int _limit = 2;

  QueryDocumentSnapshot<Map<String, dynamic>>? _lastVisible;

  final List<ProductModel> _feeds = [];

  FeedRepository({
    required this.firebaseFirestore,
    required FirebaseAuth firebaseAuth,
    required FirebaseStorage firebaseStorage,
  }) : super(
          firebaseStorage: firebaseStorage,
          firebaseAuth: firebaseAuth,
        );

  Future<List<ProductModel>> getFeed(int index) async {
    final User user = getUser();

    if (index != 0 && (index + 1) < _feeds.length) {
      return _feeds;
    }

    late QuerySnapshot<Map<String, dynamic>> productQuerySnapshot;

    Query<Map<String, dynamic>> query =
        firebaseFirestore.collection('products').orderBy(
              'createdAt',
              descending: true,
            );

    if (_lastVisible != null) {
      query = query.startAfterDocument(_lastVisible!);
    }

    productQuerySnapshot = await query.limit(_limit).get();

    if (productQuerySnapshot.docs.isEmpty) {
      return _feeds;
    }

    _lastVisible = productQuerySnapshot.docs.last;

    _feeds.addAll(
      await Future.wait(productQuerySnapshot.docs.map(
        (product) async {
          final QuerySnapshot<Map<String, dynamic>> variantesQuerySnapshot =
              await firebaseFirestore
                  .collection('products')
                  .doc(product.id)
                  .collection("variantes")
                  .get();

          int price = 0;

          if (variantesQuerySnapshot.docs.isNotEmpty) {
            price = variantesQuerySnapshot.docs
                .map((e) => int.parse(e.data()['price']))
                .reduce((curr, next) => curr < next ? curr : next);
          }

          final List<dynamic> media = [
            ...product.data()["media"] ?? [],
            ...variantesQuerySnapshot.docs.isNotEmpty
                ? variantesQuerySnapshot.docs
                    .map((variante) => variante.data()["media"])
                    .toList()
                    .expand((element) => element)
                    .toList()
                : [],
          ];

          List<VarianteModel> variantes =
              (await Future.wait(variantesQuerySnapshot.docs.map(
            (e) async {
              final List<OptionModel> options = createOptions(e.data());

              final String media = await getMediaUrlFromStorage(
                e.data()["media"][0],
              );

              return VarianteModel.fromJson({
                "id": e.id,
                ...e.data(),
                "media": media,
                "options": options,
                "price": int.parse(e.data()["price"]),
              });
            },
          )))
                  .toList();

          final List<String> mediaUrls = await Future.wait(
            media.map(
              (mediaUrl) async => await getMediaUrlFromStorage(mediaUrl),
            ),
          );

          DocumentSnapshot<Map<String, dynamic>> favoriteDocumentSnapshot =
              await firebaseFirestore
                  .collection("users")
                  .doc(user.uid)
                  .collection("favorites")
                  .doc(product.id)
                  .get();

          return ProductModel.fromJson({
            "id": product.id,
            "price": price,
            "reference": product.reference,
            ...product.data(),
            "mediaType": "MediaTypeEnum.image",
            "media": mediaUrls,
            "isFavorite": favoriteDocumentSnapshot.exists,
            "variantes": variantes,
          });
        },
      )),
    );

    return _feeds;
  }
}

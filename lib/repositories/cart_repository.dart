import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_noopeshop_app/models/cart_model.dart';
import 'package:com_noopeshop_app/models/option_model.dart';
import 'package:com_noopeshop_app/repositories/abstracts/options_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CartRepository extends OptionsRepositoryAbstract {
  final FirebaseFirestore firebaseFirestore;

  CartRepository({
    required this.firebaseFirestore,
    required FirebaseAuth firebaseAuth,
    required FirebaseStorage firebaseStorage,
  }) : super(
          firebaseStorage: firebaseStorage,
          firebaseAuth: firebaseAuth,
        );

  final StreamController<List<CartModel>> _cartController =
      StreamController<List<CartModel>>.broadcast();

  Stream<List<CartModel>> get cartStream => _cartController.stream;

  Future<void> loadCarts() async {
    final User user = getUser();

    final Stream<QuerySnapshot<Map<String, dynamic>>> cartsQuerySnapshot =
        firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .collection('carts')
            .snapshots();

    cartsQuerySnapshot.listen((cartSnapshot) async {
      List<CartModel> carts =
          (await Future.wait(cartSnapshot.docs.map((doc) async {
        final Map<String, dynamic> cartData = doc.data();

        // Récupération de la variante du produit
        final DocumentSnapshot varianteDocumentSnapshot =
            await cartData['varianteRef'].get();

        final Map<String, dynamic> varianteData =
            varianteDocumentSnapshot.data() as Map<String, dynamic>;

        final List<OptionModel> options = createOptions(varianteData);

        final String media = await getMediaUrlFromStorage(
          varianteData["media"][0],
        );

        return CartModel.fromJson({
          "id": doc.id,
          "title": cartData["title"],
          "productId": cartData["productId"],
          "price": cartData["price"],
          "quantity": cartData["quantity"],
          "varianteModel": {
            ...varianteDocumentSnapshot.data() as Map<String, dynamic>,
            "id": varianteDocumentSnapshot.id,
            "price": int.parse(varianteData["price"].toString()),
            "media": media,
            "options": options,
          },
          "optionModel": options.isNotEmpty
              ? options[0].toJson()
              : OptionModel.empty().toJson(),
        });
      })))
              .toList();

      _cartController.add(carts);
    });
  }

  Future<CartModel> addToCart(Map<String, dynamic> data) async {
    final User user = getUser();

    if (data["id"].isEmpty) {
      final Map<String, dynamic> cartProduct = {
        "title": data["title"],
        "productId": data["productId"],
        "price": data["price"],
        "quantity": 1,
        "productRef":
            firebaseFirestore.collection('products').doc(data["productId"]),
        "varianteRef": firebaseFirestore
            .collection('products')
            .doc(data["productId"])
            .collection('variantes')
            .doc(data["varianteModel"]["id"]),
        "options": data["optionModel"],
        "createdAt": Timestamp.now(),
      };

      DocumentReference<Map<String, dynamic>> cartDocumentReference =
          await firebaseFirestore
              .collection('users')
              .doc(user.uid)
              .collection('carts')
              .add(cartProduct);

      return CartModel.fromJson({
        "id": cartDocumentReference.id,
        "productId": data["productId"],
        "title": data["title"],
        "price": data["price"],
        "quantity": 1,
        "varianteModel": data["varianteModel"],
        "optionModel": data["optionModel"],
      });
    } else {
      await incrementCart(data["id"]);

      return CartModel.fromJson({
        "id": data["id"],
        "productId": data["productId"],
        "title": data["title"],
        "price": data["price"],
        "quantity": data["quantity"] + 1,
        "varianteModel": data["varianteModel"],
        "optionModel": data["optionModel"],
      });
    }
  }

  Future<void> incrementCart(String cartId) async {
    final User user = getUser();

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .collection('carts')
        .doc(cartId)
        .update({
      "quantity": FieldValue.increment(1),
    });
  }

  Future<void> decrementCart(String cartId) async {
    final User user = getUser();

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .collection('carts')
        .doc(cartId)
        .update({
      "quantity": FieldValue.increment(-1),
    });
  }
}

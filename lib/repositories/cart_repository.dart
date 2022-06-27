import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_noopeshop_app/models/cart_model.dart';
import 'package:com_noopeshop_app/models/option_model.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:com_noopeshop_app/models/variante_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CartRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final FirebaseAuth firebaseAuth;

  const CartRepository({
    required this.firebaseFirestore,
    required this.firebaseStorage,
    required this.firebaseAuth,
  });

  Future<ProductModel> _getProductModel(
    User user,
    DocumentSnapshot<Map<String, dynamic>> product,
  ) async {
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
      ...product.data()!["media"] ?? [],
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
        late List<OptionModel> options;

        if (e.data()["type"] == "size") {
          options = Map<String, dynamic>.from(e.data()["optionId"])
              .entries
              .map((e) => OptionModel(
                    key: e.key,
                    value: e.value,
                  ))
              .where((option) => option.value == true)
              .toList();
        }

        final String media = await firebaseStorage
            .ref()
            .child(e.data()["media"][0])
            .getDownloadURL();

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
        (mediaUrl) async =>
            await firebaseStorage.ref().child(mediaUrl).getDownloadURL(),
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
      ...product.data() as Map<String, dynamic>,
      "mediaType": "MediaTypeEnum.image",
      "media": mediaUrls,
      "isFavorite": favoriteDocumentSnapshot.exists,
      "variantes": variantes,
    });
  }

  Future<List<CartModel>> getCarts() async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User not found');
    }

    final QuerySnapshot<Map<String, dynamic>> cartsQuerySnapshot =
        await firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .collection('carts')
            .get();

    final List<CartModel> carts = (await Future.wait(
      cartsQuerySnapshot.docs.map((doc) async {
        final Map<String, dynamic> cartData = doc.data();

        // Récupération de la variante du produit
        final DocumentSnapshot varianteDocumentSnapshot =
            await cartData['varianteRef'].get();

        final Map<String, dynamic> varianteData =
            varianteDocumentSnapshot.data() as Map<String, dynamic>;

        late List<OptionModel> options;

        if (varianteData["type"] == "size") {
          options = Map<String, dynamic>.from(varianteData["optionId"])
              .entries
              .map((e) => OptionModel(
                    key: e.key,
                    value: e.value,
                  ))
              .where((option) => option.value == true)
              .toList();
        }

        final String media = await firebaseStorage
            .ref()
            .child(varianteData["media"][0])
            .getDownloadURL();

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
          "optionModel": options[0].toJson(),
        });
      }),
    ))
        .toList();

    return carts;
  }

  Future<CartModel> addToCart(Map<String, dynamic> data) async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User not found');
    }

    print(data["id"]);

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
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User not found');
    }

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
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User not found');
    }

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

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_noopeshop_app/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class OrdersRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  OrdersRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  Future<List<OrderModel>> loadOrders() async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User not found');
    }

    final QuerySnapshot<Map<String, dynamic>> ordersQuerySnapshot =
        await firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .collection('orders')
            .get();

    return (await Future.wait(
      ordersQuerySnapshot.docs.map((e) async {
        QuerySnapshot<Map<String, dynamic>> products = await firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .collection('orders')
            .doc(e.id)
            .collection("products")
            .get();

        final Map<String, dynamic> productOrderData =
            products.docs.first.data();

        final DocumentSnapshot<Map<String, dynamic>> productDocumentSnapshot =
            await productOrderData["productRef"].get();

        final Map<String, dynamic> productData =
            productDocumentSnapshot.data()!;

        final String media = await firebaseStorage
            .ref()
            .child(productData["media"].first)
            .getDownloadURL();

        return OrderModel.fromJson({
          'id': e.id,
          'amount': e.data()['amount'],
          'updatedAt': e.data()['updatedAt'],
          'numberProducts': products.docs.length,
          'status': e.data()['status'],
          'media': media,
        });
      }),
    ))
        .toList();
  }
}

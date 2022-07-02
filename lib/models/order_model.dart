import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum OrdersStatus {
  pending,
  paid,
  cancelled,
  unpaid,
  processing,
  shipping,
  delivered,
}

class OrderModel extends Equatable {
  final String id;
  final int amount;
  final int numberProducts;
  final String media;
  final OrdersStatus status;
  final Timestamp updatedAt;

  const OrderModel({
    required this.id,
    required this.amount,
    required this.numberProducts,
    required this.media,
    required this.status,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      amount: json['amount'] as int,
      numberProducts: json['numberProducts'] as int,
      media: json['media'] as String,
      status: OrdersStatus.values.firstWhere(
        (element) => element.toString() == json['status'],
      ),
      updatedAt: json['updatedAt'] as Timestamp,
    );
  }

  @override
  List<Object?> get props => [
        id,
        amount,
        numberProducts,
        media,
        status,
        updatedAt,
      ];
}

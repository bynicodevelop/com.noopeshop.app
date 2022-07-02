import 'package:com_noopeshop_app/models/option_model.dart';
import 'package:com_noopeshop_app/models/variante_model.dart';
import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final String id;
  final String productId;
  final String title;
  final int price;
  final VarianteModel varianteModel;
  final OptionModel optionModel;
  final int quantity;

  const CartModel({
    this.id = "",
    required this.productId,
    required this.title,
    required this.price,
    required this.varianteModel,
    required this.optionModel,
    required this.quantity,
  });

  bool get isEmpty => varianteModel.id.isEmpty;

  factory CartModel.empty() => CartModel(
        productId: "",
        title: "",
        price: 0,
        varianteModel: VarianteModel.empty(),
        optionModel: OptionModel.empty(),
        quantity: 0,
      );

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] as String,
      productId: json['productId'] as String,
      title: json['title'] as String,
      price: json['price'] as int,
      varianteModel: VarianteModel.fromJson(json['varianteModel']),
      optionModel: OptionModel.fromJson(json['optionModel']),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'price': price,
      'varianteModel': varianteModel.toJson(),
      'optionModel': optionModel.toJson(),
      'quantity': quantity,
    };
  }

  @override
  List<Object> get props => [
        id,
        productId,
        title,
        price,
        varianteModel,
        optionModel,
        quantity,
      ];
}

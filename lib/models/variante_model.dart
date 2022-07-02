import 'package:com_noopeshop_app/models/option_model.dart';
import 'package:equatable/equatable.dart';

class VarianteModel extends Equatable {
  final String id;
  final String name;
  final int price;
  final String type;
  final String media;
  final List<OptionModel> options;

  const VarianteModel({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.media,
    required this.options,
  });

  factory VarianteModel.fromJson(Map<String, dynamic> json) {
    return VarianteModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      type: json['type'] as String,
      media: json['media'] as String,
      options: json['options'] as dynamic,
    );
  }

  factory VarianteModel.empty() => const VarianteModel(
        id: '',
        name: '',
        price: 0,
        type: '',
        media: '',
        options: [],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'type': type,
      'media': media,
      'options': options,
    };
  }

  @override
  List<Object> get props => [
        id,
        name,
        price,
        type,
        media,
        options,
      ];
}

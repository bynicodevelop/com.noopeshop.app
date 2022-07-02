import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_noopeshop_app/models/feed_model.dart';
import 'package:com_noopeshop_app/models/variante_model.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final int price;
  final List<String> media;
  final MediaTypeEnum mediaType;
  final DocumentReference? reference;
  final bool isFavorite;
  final List<VarianteModel> variantes;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.media,
    required this.mediaType,
    this.reference,
    this.isFavorite = false,
    this.variantes = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] ?? 0) as int,
      media: json['media'] as List<String>,
      mediaType: MediaTypeEnum.values
          .firstWhere((element) => element.toString() == json['mediaType']),
      reference: json['reference'] as DocumentReference,
      isFavorite: json['isFavorite'] ?? false,
      variantes: json['variantes'] ?? [],
    );
  }

  factory ProductModel.empty() {
    return const ProductModel(
      id: '',
      title: '',
      description: '',
      price: 0,
      media: [],
      mediaType: MediaTypeEnum.image,
      isFavorite: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'media': media,
      'mediaType': mediaType,
      'reference': reference,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        media,
        mediaType,
        reference,
        isFavorite,
        variantes,
      ];
}

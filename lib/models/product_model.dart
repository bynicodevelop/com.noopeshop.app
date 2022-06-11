import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_noopeshop_app/models/feed_model.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<String> media;
  final MediaTypeEnum mediaType;
  final DocumentReference? reference;
  final bool isFavorite;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.media,
    required this.mediaType,
    this.reference,
    this.isFavorite = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      media: json['media'] as List<String>,
      mediaType: MediaTypeEnum.values
          .firstWhere((element) => element.toString() == json['mediaType']),
      reference: json['reference'] as DocumentReference,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  factory ProductModel.empty() {
    return const ProductModel(
      id: '',
      title: '',
      description: '',
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
        media,
        mediaType,
        reference,
        isFavorite,
      ];
}

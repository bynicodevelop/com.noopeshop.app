import 'package:equatable/equatable.dart';

enum MediaTypeEnum {
  image,
  video,
}

class FeedModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String media;
  final MediaTypeEnum mediaType;

  const FeedModel({
    required this.id,
    required this.title,
    required this.description,
    required this.media,
    required this.mediaType,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      media: json['media'] as String,
      mediaType: MediaTypeEnum.values
          .firstWhere((element) => element.toString() == json['mediaType']),
    );
  }

  factory FeedModel.empty() {
    return const FeedModel(
      id: '',
      title: '',
      description: '',
      media: '',
      mediaType: MediaTypeEnum.image,
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        description,
        media,
        mediaType,
      ];
}

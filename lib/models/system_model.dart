import 'package:equatable/equatable.dart';

class SystemModel extends Equatable {
  final bool hasSwipe;
  final bool hasAddToFavorites;

  const SystemModel({
    required this.hasSwipe,
    required this.hasAddToFavorites,
  });

  factory SystemModel.fromJson(Map<String, dynamic> json) {
    return SystemModel(
      hasSwipe: json['hasSwipe'] ?? false,
      hasAddToFavorites: json['hasAddToFavorites'] ?? false,
    );
  }

  factory SystemModel.empty() => const SystemModel(
        hasSwipe: false,
        hasAddToFavorites: false,
      );

  @override
  List<Object?> get props => [
        hasSwipe,
        hasAddToFavorites,
      ];
}

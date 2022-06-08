part of 'favorite_button_bloc.dart';

abstract class FavoriteButtonState extends Equatable {
  const FavoriteButtonState();

  @override
  List<Object> get props => [];
}

class FavoriteButtonInitialState extends FavoriteButtonState {
  final bool isLiked;

  const FavoriteButtonInitialState({
    this.isLiked = false,
  });

  @override
  List<Object> get props => [
        isLiked,
      ];
}

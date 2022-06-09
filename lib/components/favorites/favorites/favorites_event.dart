part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class OnLoadFavorites extends FavoritesEvent {}

class OnLoadedFavorites extends FavoritesEvent {
  final List<ProductModel> favorites;

  const OnLoadedFavorites({
    required this.favorites,
  });

  @override
  List<Object> get props => [
        favorites,
      ];
}

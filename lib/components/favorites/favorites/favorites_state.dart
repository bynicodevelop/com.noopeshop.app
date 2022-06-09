part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitialState extends FavoritesState {
  final List<ProductModel> favorites;

  const FavoritesInitialState({
    required this.favorites,
  });

  @override
  List<Object> get props => [
        favorites,
      ];
}

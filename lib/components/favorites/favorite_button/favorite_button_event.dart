part of 'favorite_button_bloc.dart';

abstract class FavoriteButtonEvent extends Equatable {
  const FavoriteButtonEvent();

  @override
  List<Object> get props => [];
}

class OnInitilizeFavoriteButtonEvent extends FavoriteButtonEvent {
  final ProductModel productModel;

  const OnInitilizeFavoriteButtonEvent({
    required this.productModel,
  });

  @override
  List<Object> get props => [
        productModel,
      ];
}

class OnUpdateFavoriteButtonEvent extends FavoriteButtonEvent {
  final ProductModel productModel;

  const OnUpdateFavoriteButtonEvent({
    required this.productModel,
  });

  @override
  List<Object> get props => [
        productModel,
      ];
}

class OnFavoriteButtonPressed extends FavoriteButtonEvent {
  final ProductModel productModel;

  const OnFavoriteButtonPressed({
    required this.productModel,
  });

  @override
  List<Object> get props => [
        productModel,
      ];
}

part of 'favorite_button_bloc.dart';

abstract class FavoriteButtonState extends Equatable {
  const FavoriteButtonState();

  @override
  List<Object> get props => [];
}

class FavoriteButtonInitialState extends FavoriteButtonState {
  final ProductModel productModel;

  const FavoriteButtonInitialState({
    required this.productModel,
  });

  @override
  List<Object> get props => [
        productModel,
      ];
}

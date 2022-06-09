part of 'favorite_button_bloc.dart';

abstract class FavoriteButtonState extends Equatable {
  const FavoriteButtonState();

  @override
  List<Object> get props => [];
}

class FavoriteButtonInitialState extends FavoriteButtonState {
  final ProductModel productModel;
  final int refresh;

  const FavoriteButtonInitialState({
    required this.productModel,
    this.refresh = 0,
  });

  @override
  List<Object> get props => [
        productModel,
        refresh,
      ];
}

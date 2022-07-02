part of 'cart_product_bloc.dart';

abstract class CartProductState extends Equatable {
  const CartProductState();

  @override
  List<Object> get props => [];
}

class CartProductInitialState extends CartProductState {
  final CartModel cartModel;

  const CartProductInitialState({
    required this.cartModel,
  });

  @override
  List<Object> get props => [
        cartModel,
      ];
}

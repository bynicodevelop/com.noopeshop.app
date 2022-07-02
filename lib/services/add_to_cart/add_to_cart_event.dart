part of 'add_to_cart_bloc.dart';

abstract class AddToCartEvent extends Equatable {
  const AddToCartEvent();

  @override
  List<Object> get props => [];
}

class OnLoadCartEvent extends AddToCartEvent {}

class OnLoadedCartEvent extends AddToCartEvent {
  final List<CartModel> carts;

  const OnLoadedCartEvent({
    required this.carts,
  });

  @override
  List<Object> get props => [
        carts,
      ];
}

class OnAddToCartEvent extends AddToCartEvent {
  final CartModel cart;

  const OnAddToCartEvent({
    required this.cart,
  });

  @override
  List<Object> get props => [
        cart,
      ];
}

class OnIncrementCartEvent extends AddToCartEvent {
  final CartModel cart;

  const OnIncrementCartEvent({
    required this.cart,
  });

  @override
  List<Object> get props => [
        cart,
      ];
}

class OnDecrementCartEvent extends AddToCartEvent {
  final CartModel cart;

  const OnDecrementCartEvent({
    required this.cart,
  });

  @override
  List<Object> get props => [
        cart,
      ];
}

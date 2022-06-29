part of 'add_to_cart_bloc.dart';

abstract class AddToCartState extends Equatable {
  const AddToCartState();

  @override
  List<Object> get props => [];
}

class AddToCartInitialState extends AddToCartState {
  final List<CartModel> carts;

  const AddToCartInitialState({
    this.carts = const [],
  });

  List<Map<String, dynamic>> toJson() => carts.map((e) => e.toJson()).toList();

  @override
  List<Object> get props => [
        carts,
      ];
}

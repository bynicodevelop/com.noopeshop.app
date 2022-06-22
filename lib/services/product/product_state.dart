part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {
  final ProductModel product;

  const ProductInitialState({
    required this.product,
  });

  @override
  List<Object> get props => [
        product,
      ];
}

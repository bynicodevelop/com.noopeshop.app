part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class OnLoadProductEvent extends ProductEvent {
  final String productId;

  const OnLoadProductEvent({
    required this.productId,
  });

  @override
  List<Object> get props => [
        productId,
      ];
}

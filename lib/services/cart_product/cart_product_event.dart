part of 'cart_product_bloc.dart';

abstract class CartProductEvent extends Equatable {
  const CartProductEvent();

  @override
  List<Object> get props => [];
}

class OnUpdateCartProductEvent extends CartProductEvent {
  final ProductModel productModel;
  final VarianteModel varianteModel;
  final OptionModel optionModel;

  const OnUpdateCartProductEvent({
    required this.productModel,
    required this.varianteModel,
    required this.optionModel,
  });

  @override
  List<Object> get props => [
        productModel,
        varianteModel,
        optionModel,
      ];
}

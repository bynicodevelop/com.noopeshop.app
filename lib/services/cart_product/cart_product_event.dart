part of 'cart_product_bloc.dart';

abstract class CartProductEvent extends Equatable {
  const CartProductEvent();

  @override
  List<Object> get props => [];
}

class OnUpdateCartProductEvent extends CartProductEvent {
  final VarianteModel varianteModel;
  final OptionModel optionModel;

  const OnUpdateCartProductEvent({
    required this.varianteModel,
    required this.optionModel,
  });

  @override
  List<Object> get props => [
        varianteModel,
        optionModel,
      ];
}

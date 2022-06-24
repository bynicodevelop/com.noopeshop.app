part of 'product_customizer_bloc.dart';

abstract class ProductCustomizerEvent extends Equatable {
  const ProductCustomizerEvent();

  @override
  List<Object> get props => [];
}

class OnChangeProductCustomizerEvent extends ProductCustomizerEvent {
  final VarianteModel varianteModel;

  const OnChangeProductCustomizerEvent({
    required this.varianteModel,
  });

  @override
  List<Object> get props => [
        varianteModel,
      ];
}

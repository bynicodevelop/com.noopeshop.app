part of 'product_customizer_bloc.dart';

abstract class ProductCustomizerState extends Equatable {
  const ProductCustomizerState();

  @override
  List<Object> get props => [];
}

class ProductCustomizerInitialState extends ProductCustomizerState {}

class ProductCustomizerLoadedState extends ProductCustomizerState {
  final VarianteModel varianteModel;

  const ProductCustomizerLoadedState({
    required this.varianteModel,
  });

  @override
  List<Object> get props => [
        varianteModel,
      ];
}

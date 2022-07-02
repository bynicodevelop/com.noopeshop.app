part of 'variantes_bloc.dart';

abstract class VariantesState extends Equatable {
  const VariantesState();

  @override
  List<Object> get props => [];
}

class VariantesInitialState extends VariantesState {
  final VarianteModel varianteModel;

  const VariantesInitialState({
    required this.varianteModel,
  });

  @override
  List<Object> get props => [
        varianteModel,
      ];
}

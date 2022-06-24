part of 'variantes_bloc.dart';

abstract class VariantesEvent extends Equatable {
  const VariantesEvent();

  @override
  List<Object> get props => [];
}

class OnSelectVarianteEvent extends VariantesEvent {
  final VarianteModel varianteModel;

  const OnSelectVarianteEvent({
    required this.varianteModel,
  });

  @override
  List<Object> get props => [
        varianteModel,
      ];
}

import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/models/variante_model.dart';
import 'package:equatable/equatable.dart';

part 'variantes_event.dart';
part 'variantes_state.dart';

class VariantesBloc extends Bloc<VariantesEvent, VariantesState> {
  final VarianteModel varianteModel;

  VariantesBloc({
    required this.varianteModel,
  }) : super(
          VariantesInitialState(
            varianteModel: varianteModel,
          ),
        ) {
    on<OnSelectVarianteEvent>((event, emit) {
      emit(VariantesInitialState(
        varianteModel: event.varianteModel,
      ));
    });
  }
}

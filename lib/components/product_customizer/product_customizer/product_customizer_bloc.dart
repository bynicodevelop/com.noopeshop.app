import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/models/variante_model.dart';
import 'package:equatable/equatable.dart';

part 'product_customizer_event.dart';
part 'product_customizer_state.dart';

class ProductCustomizerBloc
    extends Bloc<ProductCustomizerEvent, ProductCustomizerState> {
  ProductCustomizerBloc() : super(ProductCustomizerInitialState()) {
    on<OnChangeProductCustomizerEvent>((event, emit) {
      emit(ProductCustomizerLoadedState(
        varianteModel: event.varianteModel,
      ));
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/models/cart_model.dart';
import 'package:com_noopeshop_app/models/option_model.dart';
import 'package:com_noopeshop_app/models/variante_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_product_event.dart';
part 'cart_product_state.dart';

class CartProductBloc extends Bloc<CartProductEvent, CartProductState> {
  CartProductBloc()
      : super(CartProductInitialState(
          cartModel: CartModel.empty(),
        )) {
    on<OnUpdateCartProductEvent>((event, emit) {
      final CartModel cartModel = CartModel(
        varianteModel: event.varianteModel,
        optionModel: event.optionModel,
      );

      emit(CartProductInitialState(
        cartModel: cartModel,
      ));
    });
  }
}

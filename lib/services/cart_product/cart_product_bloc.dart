// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/models/cart_model.dart';
import 'package:com_noopeshop_app/models/option_model.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
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
        productId: event.productModel.id,
        title: event.productModel.title,
        price: event.varianteModel.price,
        varianteModel: event.varianteModel,
        optionModel: event.optionModel,
        quantity: 0,
      );

      emit(CartProductInitialState(
        cartModel: cartModel,
      ));
    });
  }
}

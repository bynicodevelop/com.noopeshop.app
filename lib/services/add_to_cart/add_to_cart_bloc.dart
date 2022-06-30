// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/models/cart_model.dart';
import 'package:com_noopeshop_app/repositories/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final CartRepository cartRepository;

  AddToCartBloc({
    required this.cartRepository,
  }) : super(const AddToCartInitialState()) {
    cartRepository.cartStream.listen((carts) {
      add(OnLoadedCartEvent(carts: carts));
    });

    on<OnLoadCartEvent>(((event, emit) {
      cartRepository.loadCarts();
    }));

    on<OnLoadedCartEvent>((event, emit) {
      emit(AddToCartInitialState(
        carts: event.carts,
      ));
    });

    on<OnAddToCartEvent>((event, emit) async {
      final CartModel cartModel = event.cart;

      final List<CartModel> carts = (await Future.wait(
        (state as AddToCartInitialState).carts.map((cart) async {
          if (cart.varianteModel.id == cartModel.varianteModel.id &&
              cart.optionModel.value == cartModel.optionModel.value) {
            final CartModel updatedCartModel = await cartRepository.addToCart(
              {
                "id": cart.id,
                "productId": cart.productId,
                "title": cart.title,
                "price": cart.price,
                "varianteModel": cart.varianteModel.toJson(),
                "optionModel": cart.optionModel.toJson(),
                "quantity": cart.quantity
              },
            );

            return updatedCartModel;
          }

          return cart;
        }),
      ))
          .toList();

      CartModel cartModelFound = (state as AddToCartInitialState)
          .carts
          .firstWhere(
              (cart) =>
                  cart.varianteModel.id == cartModel.varianteModel.id &&
                  cart.optionModel.value == cartModel.optionModel.value,
              orElse: () => CartModel.empty());

      if (cartModelFound.isEmpty) {
        final CartModel newCartModel = await cartRepository.addToCart(
          cartModel.toJson(),
        );

        carts.add(newCartModel);
      }
    });

    on<OnIncrementCartEvent>(((event, emit) async {
      final CartModel cartModel = event.cart;

      (await Future.wait(
        (state as AddToCartInitialState).carts.map((cart) async {
          if (cart.varianteModel.id == cartModel.varianteModel.id &&
              cart.optionModel.value == cartModel.optionModel.value) {
            await cartRepository.incrementCart(cart.id);
          }

          return CartModel.fromJson({
            ...cart.toJson(),
            "quantity": cart.quantity + 1,
          });
        }),
      ))
          .toList();
    }));

    on<OnDecrementCartEvent>(((event, emit) async {
      final CartModel cartModel = event.cart;

      (await Future.wait(
        (state as AddToCartInitialState).carts.map((cart) async {
          if (cart.varianteModel.id == cartModel.varianteModel.id &&
              cart.optionModel.value == cartModel.optionModel.value) {
            await cartRepository.decrementCart(cart.id);
          }

          return CartModel.fromJson({
            ...cart.toJson(),
            "quantity": cart.quantity - 1,
          });
        }),
      ))
          .toList();
    }));
  }
}

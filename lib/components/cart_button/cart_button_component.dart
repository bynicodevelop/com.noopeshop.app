import 'package:com_noopeshop_app/config/constants.dart';
import 'package:com_noopeshop_app/models/cart_model.dart';
import 'package:com_noopeshop_app/services/add_to_cart/add_to_cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartButtonComponent extends StatelessWidget {
  const CartButtonComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToCartBloc, AddToCartState>(
      builder: (context, state) {
        final List<CartModel> carts = (state as AddToCartInitialState).carts;

        if (carts.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(
            top: 2,
            right: 2,
          ),
          child: CircleAvatar(
            radius: 10.0,
            backgroundColor: kBackgroundColor,
            child: Text(
              carts
                  .fold<int>(
                    0,
                    (previousValue, element) =>
                        previousValue + element.quantity,
                  )
                  .toString(),
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
            ),
          ),
        );
      },
    );
  }
}

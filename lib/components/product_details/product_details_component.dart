import 'package:another_flushbar/flushbar.dart';
import 'package:com_noopeshop_app/components/variantes/variante_component.dart';
import 'package:com_noopeshop_app/config/constants.dart';
import 'package:com_noopeshop_app/models/cart_model.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:com_noopeshop_app/services/add_to_cart/add_to_cart_bloc.dart';
import 'package:com_noopeshop_app/services/cart_product/cart_product_bloc.dart';
import 'package:com_noopeshop_app/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProductDetailsComponent extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailsComponent({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 22.0,
        right: 30.0,
        left: 30.0,
        bottom: 35.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: kBackgroundColor.withOpacity(.3),
            blurRadius: 20.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: BlocProvider<CartProductBloc>(
        create: (context) => CartProductBloc(),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 32.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 5.0,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                bottom: 16.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.title,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.black,
                      shadows: [],
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<CartProductBloc, CartProductState>(
                    builder: (context, state) {
                      final CartModel cartModel =
                          (state as CartProductInitialState).cartModel;

                      return Text(
                        NumberFormat.currency(
                          locale: 'fr_FR',
                          symbol: '€',
                        ).format(
                          cartModel.price / 100,
                        ),
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.black,
                          shadows: [],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            /// Description
            Padding(
              padding: const EdgeInsets.only(
                bottom: 22.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    productModel.description,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.black,
                      shadows: [],
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                bottom: 22.0,
              ),
              child: VarianteComponent(
                productModel: productModel,
              ),
            ),

            BlocBuilder<CartProductBloc, CartProductState>(
              builder: (context, state) {
                final CartModel cartModel =
                    (state as CartProductInitialState).cartModel;

                return BlocListener<AddToCartBloc, AddToCartState>(
                  listener: (context, state) {
                    Flushbar(
                      title: 'Ajout au panier',
                      message: 'Le produit a été ajouté au panier',
                      backgroundColor: Colors.green,
                      duration: const Duration(
                        seconds: 2,
                      ),
                      flushbarPosition: FlushbarPosition.TOP,
                      margin: const EdgeInsets.all(16.0),
                      borderRadius: BorderRadius.circular(16.0),
                      flushbarStyle: FlushbarStyle.FLOATING,
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ).show(context);
                  },
                  child: MainButton(
                    onPressed: () {
                      context.read<AddToCartBloc>().add(
                            OnAddToCartEvent(
                              cart: cartModel,
                            ),
                          );
                    },
                    label: "Add to card".toUpperCase(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

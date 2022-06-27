import 'package:com_noopeshop_app/config/constants.dart';
import 'package:com_noopeshop_app/models/cart_model.dart';
import 'package:com_noopeshop_app/services/add_to_cart/add_to_cart_bloc.dart';
import 'package:com_noopeshop_app/widgets/cart_total_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToCartBloc, AddToCartState>(
      builder: (context, state) {
        final List<CartModel> carts = (state as AddToCartInitialState).carts;

        print(carts);

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              bottom: 275.0,
            ),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      "Panier".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: kBackgroundColor,
                      ),
                    ),
                  ),
                ),
                if (carts.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Text(
                        "No carts in cart",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                if (carts.isNotEmpty)
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (_, int index) {
                      return Container(
                        margin: const EdgeInsets.only(
                          top: 15.0,
                          bottom: 20.0,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            16.0,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 16.0,
                              ),
                              child: SizedBox(
                                width: 120,
                                height: 120,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    16.0,
                                  ),
                                  child: Image.network(
                                    carts[index].varianteModel.media,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Wrap(
                                runSpacing: 25,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                        ),
                                        child: Text(
                                          carts[index].title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                          locale: "fr_FR",
                                          symbol: "€",
                                        ).format(
                                          carts[index].price / 100,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                              color: kDefaultColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10.0,
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () =>
                                              context.read<AddToCartBloc>().add(
                                                    OnDecrementCartEvent(
                                                      cart: carts[index],
                                                    ),
                                                  ),
                                          style: ElevatedButton.styleFrom(
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              vertical: 2.0,
                                            ),
                                            minimumSize: Size.zero,
                                            primary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          child: const Text(
                                            "-",
                                            style: TextStyle(
                                              fontSize: 22.0,
                                              color: kBackgroundColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${carts[index].quantity}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              fontSize: 15.0,
                                            ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            context.read<AddToCartBloc>().add(
                                                  OnIncrementCartEvent(
                                                    cart: carts[index],
                                                  ),
                                                ),
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                            vertical: 2.0,
                                          ),
                                          minimumSize: Size.zero,
                                          primary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        child: const Text(
                                          "+",
                                          style: TextStyle(
                                            fontSize: 22.0,
                                            color: kBackgroundColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: carts.length,
                  )),
              ],
            ),
          ),
          bottomSheet: BottomSheet(
            enableDrag: false,
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            onClosing: () {},
            builder: (context) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: kBackgroundColor.withOpacity(0.1),
                      offset: const Offset(0, -2),
                      blurRadius: 10.0,
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 28.0,
                    right: 28.0,
                    top: 32.0,
                    bottom: 52.0,
                  ),
                  child: Wrap(
                    children: [
                      CartTotalWidget(
                        subtotal: carts.fold(
                          0,
                          (previousValue, element) =>
                              previousValue +
                              int.parse(
                                      element.varianteModel.price.toString()) *
                                  int.parse(
                                    element.quantity.toString(),
                                  ),
                        ),
                        tax: carts.fold(
                          0,
                          (previousValue, element) =>
                              previousValue +
                              int.parse(0.toString()) *
                                  int.parse(
                                    element.quantity.toString(),
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 60.0,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kDefaultColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: carts.isNotEmpty ? () {} : null,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Continuer",
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.1,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:com_noopeshop_app/config/functions/translate.dart';
import 'package:com_noopeshop_app/models/cart_model.dart';
import 'package:com_noopeshop_app/services/checkout/checkout_bloc.dart';
import 'package:com_noopeshop_app/utils/math_sum.dart';
import 'package:com_noopeshop_app/widgets/cart_total_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class PaymentScreen extends StatefulWidget {
  final List<CartModel> carts;

  const PaymentScreen({
    Key? key,
    required this.carts,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardExpiryController = TextEditingController();
  final TextEditingController _cardCvvController = TextEditingController();

  final FocusNode _cardNumberFocusNode = FocusNode();
  final FocusNode _cardExpiryFocusNode = FocusNode();
  final FocusNode _cardCvvFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _cardNumberController.addListener(() {
      if (_cardNumberController.text.length == 19) {
        _cardExpiryFocusNode.requestFocus();
      }

      context.read<CheckoutBloc>().add(OnFormUpdatedCheckoutEvent(
            formData: {
              "cardNumber": _cardNumberController.text,
            },
          ));
    });

    _cardExpiryController.addListener(() {
      if (_cardExpiryController.text.length == 5) {
        _cardCvvFocusNode.requestFocus();
      }

      context.read<CheckoutBloc>().add(OnFormUpdatedCheckoutEvent(
            formData: {
              "cardExpiry": _cardExpiryController.text,
            },
          ));
    });

    _cardCvvController.addListener(() {
      context.read<CheckoutBloc>().add(OnFormUpdatedCheckoutEvent(
            formData: {
              "cardCvv": _cardCvvController.text,
            },
          ));
    });

    _cardNumberFocusNode.requestFocus();

    if (kDebugMode) {
      _cardNumberController.text = "4242424242424242";
      _cardExpiryController.text = "12/20";
      _cardCvvController.text = "123";
    }
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardExpiryController.dispose();
    _cardCvvController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 28.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 52.0,
              ),
              child: Text(
                t(context)!.paymentAppBar.toUpperCase(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 22.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      bottom: 16.0,
                    ),
                    child: Text(
                      t(context)!.deliveryLabelField,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  TextField(
                    controller: _cardNumberController,
                    focusNode: _cardNumberFocusNode,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      CreditCardNumberInputFormatter(
                        onCardSystemSelected: (cardSystem) {
                          print(cardSystem);
                        },
                        useSeparators: true,
                      ),
                    ],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 22.0,
                        vertical: 20.0,
                      ),
                      hintText: "XXXX XXXX XXXX XXXX",
                      filled: true,
                      fillColor: Colors.grey.withOpacity(.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 16.0,
                        ),
                        child: Icon(
                          Icons.credit_card,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 52.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            bottom: 16.0,
                          ),
                          child: Text(
                            t(context)!.expirationField,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        TextField(
                          controller: _cardExpiryController,
                          focusNode: _cardExpiryFocusNode,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            CreditCardExpirationDateFormatter(),
                            // TODO: Verifier l'expiration de la date
                          ],
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 22.0,
                              vertical: 20.0,
                            ),
                            hintText: "MM/YY",
                            filled: true,
                            fillColor: Colors.grey.withOpacity(.1),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 16.0,
                          ),
                          child: Text(
                            t(context)!.secureCodeField,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        TextField(
                          controller: _cardCvvController,
                          focusNode: _cardCvvFocusNode,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            CreditCardCvcInputFormatter(),
                          ],
                          decoration: InputDecoration(
                            hintText: "000",
                            filled: true,
                            fillColor: Colors.grey.withOpacity(.1),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: CartTotalWidget(
                subtotal: calculateSumPrice(
                  widget.carts.map((cart) => cart.toJson()).toList(),
                ),
                tax: calculateSumTax([]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

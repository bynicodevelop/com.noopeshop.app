import 'package:another_flushbar/flushbar.dart';
import 'package:com_noopeshop_app/config/constants.dart';
import 'package:com_noopeshop_app/config/functions/translate.dart';
import 'package:com_noopeshop_app/config/validators/card_number_validator.dart';
import 'package:com_noopeshop_app/config/validators/city_validator.dart';
import 'package:com_noopeshop_app/config/validators/cvc_code_validator.dart';
import 'package:com_noopeshop_app/config/validators/email_validator.dart';
import 'package:com_noopeshop_app/config/validators/expiry_validator.dart';
import 'package:com_noopeshop_app/config/validators/name_validator.dart';
import 'package:com_noopeshop_app/config/validators/postal_code_validator.dart';
import 'package:com_noopeshop_app/config/validators/shipping_address_validator.dart';
import 'package:com_noopeshop_app/screens/checkout/contact_screen.dart';
import 'package:com_noopeshop_app/screens/checkout/delivery_screen.dart';
import 'package:com_noopeshop_app/screens/checkout/payment_screen.dart';
import 'package:com_noopeshop_app/screens/checkout/success_payment_screen.dart';
import 'package:com_noopeshop_app/screens/home_screen.dart';
import 'package:com_noopeshop_app/services/add_to_cart/add_to_cart_bloc.dart';
import 'package:com_noopeshop_app/services/checkout/checkout_bloc.dart';
import 'package:com_noopeshop_app/services/payment/payment_bloc.dart';
import 'package:com_noopeshop_app/widgets/progress_bullet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  int _currentPage = 0;

  void _errorMessage(
    BuildContext context,
    String message,
  ) =>
      Flushbar(
        title: 'Erreur',
        message: message,
        backgroundColor: Colors.red,
        duration: const Duration(
          seconds: 2,
        ),
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.all(16.0),
        borderRadius: BorderRadius.circular(16.0),
        flushbarStyle: FlushbarStyle.FLOATING,
      ).show(context);

  void _animateToPage(int currentPage) => _pageController.animateToPage(
        currentPage,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeInOut,
      );

  void _nextPage() {
    setState(() => _currentPage++);

    _animateToPage(_currentPage);
  }

  void _previousPage() {
    setState(() => _currentPage--);

    _animateToPage(_currentPage);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> checkoutPages = [
      {
        "button": t(context)!.deliveryLabelButton,
        "screen": const ContactScreen(),
        "function": (Map<String, dynamic>? data) => _nextPage(),
      },
      {
        "button": t(context)!.paymentLabelButton,
        "screen": const DeliveryScreen(),
        "function": (Map<String, dynamic>? data) => _nextPage(),
      },
      {
        "button": t(context)!.placeOrderLabelButton,
        // TODO: Optimiser, c'est utilisé trop de fois
        "screen": BlocBuilder<AddToCartBloc, AddToCartState>(
          bloc: context.read<AddToCartBloc>()..add(OnLoadCartEvent()),
          builder: (context, state) {
            return PaymentScreen(
              carts: (state as AddToCartInitialState).carts,
            );
          },
        ),
        "function": (Map<String, dynamic>? data) =>
            context.read<PaymentBloc>().add(
                  OnIntentPaymentBloc(
                    checkout: data!,
                  ),
                )
      },
      {
        "button": t(context)!.finishedLabelButton,
        "screen": const SuccessPaymentScreen(),
        "function": (Map<String, dynamic>? data) =>
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false,
            )
      }
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Stack(
          alignment: Alignment.center,
          children: [
            if (_currentPage < checkoutPages.length - 1)
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                  onPressed: () {
                    if (_currentPage == 0) {
                      Navigator.pop(context);

                      return;
                    }

                    _previousPage();
                  },
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: checkoutPages
                  .asMap()
                  .entries
                  .map((entry) => ProgressBulletWidget(
                        isFirst: entry.key == 0,
                        isActive: _currentPage > entry.key - 1,
                      ))
                  .toList(),
            )
          ],
        ),
      ),
      body: BlocProvider<CheckoutBloc>(
        create: (context) => CheckoutBloc(),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 22.0,
                  ),
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: checkoutPages
                        .map<Widget>((page) => page["screen"])
                        .toList(),
                  ),
                ),
                BlocConsumer<PaymentBloc, PaymentState>(
                  listener: (context, state) {
                    if (state is PaymentSuccessState) {
                      _nextPage();
                    }
                  },
                  builder: (context, payementState) {
                    return BlocBuilder<AddToCartBloc, AddToCartState>(
                      bloc: context.read<AddToCartBloc>()
                        ..add(OnLoadCartEvent()),
                      builder: (context, addToCartState) {
                        return BlocBuilder<CheckoutBloc, CheckoutState>(
                          builder: (context, state) {
                            print(state);
                            return KeyboardVisibilityBuilder(
                                builder: (context, isVisible) {
                              return Align(
                                alignment: isVisible &&
                                        _currentPage < checkoutPages.length - 1
                                    ? Alignment.bottomRight
                                    : Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 28.0,
                                    vertical: 20.0,
                                  ),
                                  child: SizedBox(
                                    height: 60.0,
                                    width: isVisible &&
                                            _currentPage <
                                                checkoutPages.length - 1
                                        ? 60.0
                                        : double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: kDefaultColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                      ),
                                      onPressed: payementState
                                              is PaymentLoadingState
                                          ? null
                                          : () {
                                              CheckoutInitialState
                                                  checkoutState =
                                                  state as CheckoutInitialState;

                                              if (_currentPage == 0) {
                                                if (!NameInput.dirty(
                                                  value: checkoutState.name,
                                                ).valid) {
                                                  _errorMessage(
                                                    context,
                                                    "Merci de saisir un nom",
                                                  );
                                                  return;
                                                }

                                                if (!EmailInput.dirty(
                                                  value: checkoutState.email,
                                                ).valid) {
                                                  _errorMessage(
                                                    context,
                                                    "Merci de saisir un e-mail valide",
                                                  );
                                                  return;
                                                }
                                              }

                                              if (_currentPage == 1) {
                                                if (!ShippingAddressInput.dirty(
                                                  value: checkoutState
                                                      .shippingAddress,
                                                ).valid) {
                                                  _errorMessage(
                                                    context,
                                                    "Merci de saisir une adresse de livraison",
                                                  );
                                                  return;
                                                }

                                                if (!CityInput.dirty(
                                                  value: checkoutState
                                                      .shippingCity,
                                                ).valid) {
                                                  _errorMessage(
                                                    context,
                                                    "Merci de saisir une ville",
                                                  );
                                                  return;
                                                }

                                                if (!PostalCodeInput.dirty(
                                                  value: checkoutState
                                                      .shippingPostalCode,
                                                ).valid) {
                                                  _errorMessage(
                                                    context,
                                                    "Merci de saisir un code postal",
                                                  );
                                                  return;
                                                }
                                              }

                                              if (_currentPage == 2) {
                                                if (!CardNumberInput.dirty(
                                                  value:
                                                      checkoutState.cardNumber,
                                                ).valid) {
                                                  _errorMessage(
                                                    context,
                                                    "Merci de saisir un numéro de carte",
                                                  );
                                                  return;
                                                }

                                                if (!ExpiryInput.dirty(
                                                  value:
                                                      checkoutState.cardExpiry,
                                                ).valid) {
                                                  _errorMessage(
                                                    context,
                                                    "Merci de saisir une date d'expiration",
                                                  );
                                                  return;
                                                }

                                                if (!CVCCodeInput.dirty(
                                                  value: checkoutState.cardCvv,
                                                ).valid) {
                                                  _errorMessage(
                                                    context,
                                                    "Merci de saisir un code de sécurité",
                                                  );
                                                  return;
                                                }
                                              }

                                              checkoutPages[_currentPage]
                                                  ["function"]({
                                                ...state.toJson(),
                                                "carts": (addToCartState
                                                        as AddToCartInitialState)
                                                    .toJson(),
                                              });
                                            },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment: checkoutPages
                                                          .length >
                                                      _currentPage + 1 &&
                                                  _currentPage <
                                                      checkoutPages.length -
                                                          1 &&
                                                  !isVisible
                                              ? MainAxisAlignment.spaceBetween
                                              : MainAxisAlignment.center,
                                          children: [
                                            if (!isVisible ||
                                                _currentPage ==
                                                    checkoutPages.length - 1)
                                              Text(
                                                checkoutPages[_currentPage]
                                                    ["button"],
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  letterSpacing: 1.1,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.0,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            if (checkoutPages.length >
                                                _currentPage + 1)
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.white,
                                                size: 16.0,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

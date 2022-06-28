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
import 'package:com_noopeshop_app/services/checkout/checkout_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> checkoutPages = [
      {
        "button": t(context)!.deliveryLabelButton,
        "screen": const ContactScreen(),
      },
      {
        "button": t(context)!.paymentLabelButton,
        "screen": const DeliveryScreen(),
      },
      {
        "button": t(context)!.placeOrderLabelButton,
        "screen": const PaymentScreen(),
      },
      {
        "button": t(context)!.finishedLabelButton,
        "screen": const SuccessPaymentScreen(),
      }
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Stack(
          alignment: Alignment.center,
          children: [
            if (_currentPage > 0 && _currentPage < checkoutPages.length - 1)
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                  onPressed: () {
                    setState(() => _currentPage--);

                    _pageController.previousPage(
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      curve: Curves.easeIn,
                    );
                  },
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: checkoutPages
                  .asMap()
                  .entries
                  .map((entry) => ProgressBulletWidget(
                        isFirst: entry.key == 0,
                        isActive: _currentPage > entry.key - 1,
                      ))
                  .toList(),
            ),
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
                BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    return KeyboardVisibilityBuilder(
                        builder: (context, isVisible) {
                      return Align(
                        alignment:
                            isVisible && _currentPage < checkoutPages.length - 1
                                ? Alignment.bottomRight
                                : Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 28.0,
                            vertical: isVisible ? 20.0 : 52.0,
                          ),
                          child: SizedBox(
                            height: 60.0,
                            width: isVisible &&
                                    _currentPage < checkoutPages.length - 1
                                ? 60.0
                                : double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: kDefaultColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      checkoutPages.length > _currentPage + 1 &&
                                              _currentPage <
                                                  checkoutPages.length - 1 &&
                                              !isVisible
                                          ? MainAxisAlignment.spaceBetween
                                          : MainAxisAlignment.center,
                                  children: [
                                    if (!isVisible ||
                                        _currentPage ==
                                            checkoutPages.length - 1)
                                      Text(
                                        checkoutPages[_currentPage]["button"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 1.1,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    if (checkoutPages.length > _currentPage + 1)
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 16.0,
                                      ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                CheckoutInitialState checkoutState =
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
                                    value: checkoutState.shippingAddress,
                                  ).valid) {
                                    _errorMessage(
                                      context,
                                      "Merci de saisir une adresse de livraison",
                                    );
                                    return;
                                  }

                                  if (!CityInput.dirty(
                                    value: checkoutState.shippingCity,
                                  ).valid) {
                                    _errorMessage(
                                      context,
                                      "Merci de saisir une ville",
                                    );
                                    return;
                                  }

                                  if (!PostalCodeInput.dirty(
                                    value: checkoutState.shippingPostalCode,
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
                                    value: checkoutState.cardNumber,
                                  ).valid) {
                                    _errorMessage(
                                      context,
                                      "Merci de saisir un numéro de carte",
                                    );
                                    return;
                                  }

                                  if (!ExpiryInput.dirty(
                                    value: checkoutState.cardExpiry,
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

                                setState(() => _currentPage++);

                                _pageController.animateToPage(
                                  _currentPage,
                                  duration: const Duration(
                                    milliseconds: 300,
                                  ),
                                  curve: Curves.easeInOut,
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    });
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

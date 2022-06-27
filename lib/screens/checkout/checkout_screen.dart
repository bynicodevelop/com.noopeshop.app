import 'package:com_noopeshop_app/config/constants.dart';
import 'package:com_noopeshop_app/config/functions/translate.dart';
import 'package:com_noopeshop_app/screens/checkout/contact_screen.dart';
import 'package:com_noopeshop_app/screens/checkout/delivery_screen.dart';
import 'package:com_noopeshop_app/screens/checkout/payment_screen.dart';
import 'package:com_noopeshop_app/screens/checkout/success_payment_screen.dart';
import 'package:com_noopeshop_app/widgets/progress_bullet_widget.dart';
import 'package:flutter/material.dart';

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
      body: SafeArea(
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 52.0,
                  ),
                  child: SizedBox(
                    height: 60.0,
                    width: double.infinity,
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
                              checkoutPages.length > _currentPage + 1
                                  ? MainAxisAlignment.spaceBetween
                                  : MainAxisAlignment.center,
                          children: [
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

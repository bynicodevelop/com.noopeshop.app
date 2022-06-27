import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartTotalWidget extends StatelessWidget {
  final int subtotal;
  final int tax;

  const CartTotalWidget({
    Key? key,
    required this.subtotal,
    this.tax = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Subtotal",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                NumberFormat.currency(
                  locale: "fr_FR",
                  symbol: "€",
                ).format(subtotal / 100),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 32.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Taxes"),
              Text(
                tax == 0
                    ? "Free"
                    : NumberFormat.currency(
                        locale: "fr_FR",
                        symbol: "€",
                      ).format(tax / 100),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 32.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total".toUpperCase(),
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                NumberFormat.currency(
                  locale: "fr_FR",
                  symbol: "€",
                ).format((subtotal + tax) / 100),
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

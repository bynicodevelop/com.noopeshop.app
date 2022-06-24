import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedPriceWidget extends StatelessWidget {
  final int price;

  const FeedPriceWidget({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
          ),
          child: Text(
            "A partir de",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(.6),
                  blurRadius: 5,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
          ),
        ),
        Text(
          NumberFormat.currency(
            locale: 'fr_FR',
            symbol: '€',
          ).format(
            price / 100,
          ),
          style: Theme.of(context).textTheme.headline1,
        )
      ],
    );
  }
}

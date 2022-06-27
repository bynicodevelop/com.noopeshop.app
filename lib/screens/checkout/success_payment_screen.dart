import 'package:com_noopeshop_app/config/functions/translate.dart';
import 'package:flutter/material.dart';

class SuccessPaymentScreen extends StatelessWidget {
  const SuccessPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 28.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 100.0,
            ),
            child: Text(
              t(context)!.thankyouAppBar.toUpperCase(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 42.0,
            ),
            child: Text(
              "Votre paiement a été effectué avec succès",
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ),
          const Text(
            "🎉",
            style: TextStyle(
              fontSize: 42.0,
            ),
          )
        ],
      ),
    );
  }
}

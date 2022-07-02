import 'package:com_noopeshop_app/config/functions/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: Opacity(
                  opacity: 0.05,
                  child: SvgPicture.asset(
                    "assets/logo.svg",
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
              ),
              Text(
                "Votre paiement a été effectué\n avec succès",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50.0,
            ),
            child: Image.asset(
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? 'assets/images/logo-light.png'
                  : 'assets/images/logo-black.png',
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Ne manquez plus une occasion',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    height: 1.5,
                    fontSize: 16.0,
                  ),
              children: [
                TextSpan(
                  text: '\nde faire plaisir !',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16.0,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:com_noopeshop_app/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomThemeData {
  static ThemeData themeLight(BuildContext context) {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: base.appBarTheme.copyWith(
        iconTheme: const IconThemeData(
          color: kBackgroundColor,
        ),
      ),
      textTheme: GoogleFonts.ralewayTextTheme().copyWith(
        headline1: Theme.of(context).textTheme.headline1!.copyWith(
          color: Colors.white,
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(.6),
              blurRadius: 5,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        bodyText1: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: kBackgroundColor,
              fontSize: 14.0,
              letterSpacing: .9,
              height: 1.5,
            ),
        // Use to card title
        headline2: Theme.of(context).textTheme.headline2!.copyWith(
              color: kBackgroundColor,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              letterSpacing: .9,
            ),
        // Use to app title type product (colors, size)
        headline4: Theme.of(context).textTheme.headline4!.copyWith(
              fontSize: 16.0,
              height: 1.5,
              color: kBackgroundColor,
            ),
        // Use to app title type product (colors, size)
        headline5: Theme.of(context).textTheme.headline5!.copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
        // Use to app bar title
        headline6: Theme.of(context).textTheme.headline2!.copyWith(
              color: kBackgroundColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: .9,
            ),
      ),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        unselectedIconTheme: IconThemeData(
          color: kBackgroundColor.withOpacity(.7),
        ),
        selectedIconTheme: const IconThemeData(
          color: kBackgroundColor,
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  static ThemeData themeDark(BuildContext context) {
    final ThemeData base = ThemeData.dark();

    return base.copyWith(
      primaryColor: kBackgroundColor,
      scaffoldBackgroundColor: kBackgroundColor,
      appBarTheme: base.appBarTheme.copyWith(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      textTheme: GoogleFonts.ralewayTextTheme().copyWith(
        headline1: Theme.of(context).textTheme.headline1!.copyWith(
          color: Colors.white,
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(.6),
              blurRadius: 5,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        bodyText1: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
              fontSize: 14.0,
              letterSpacing: .9,
              height: 1.5,
            ),
        // Use to card title
        headline2: Theme.of(context).textTheme.headline2!.copyWith(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              letterSpacing: .9,
            ),
        // Use to app title type product (colors, size)
        headline5: Theme.of(context).textTheme.headline5!.copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
        // Use to app bar title
        headline6: Theme.of(context).textTheme.headline2!.copyWith(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: .9,
            ),
      ),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        unselectedIconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

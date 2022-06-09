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
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(.6),
              blurRadius: 5,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        // Use to card title
        headline2: Theme.of(context).textTheme.headline2!.copyWith(
              color: kBackgroundColor,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              letterSpacing: .9,
            ),
        // Use to app bar title
        headline6: Theme.of(context).textTheme.headline2!.copyWith(
              color: kBackgroundColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: .9,
            ),
        bodyText1: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: kBackgroundColor,
              fontSize: 14.0,
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
        backgroundColor: Colors.white,
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
          color: kBackgroundColor,
        ),
      ),
      textTheme: GoogleFonts.ralewayTextTheme().copyWith(
        headline1: Theme.of(context).textTheme.headline1!.copyWith(
          color: Colors.white,
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(.6),
              blurRadius: 5,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        // Use to card title
        headline2: Theme.of(context).textTheme.headline2!.copyWith(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              letterSpacing: .9,
            ),
        // Use to app bar title
        headline6: Theme.of(context).textTheme.headline2!.copyWith(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: .9,
            ),
        bodyText1: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
              fontSize: 14.0,
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
        backgroundColor: kBackgroundColor,
        elevation: 0,
      ),
    );
  }
}

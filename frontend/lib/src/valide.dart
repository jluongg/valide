import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/src/login/login_page.dart';
import 'package:frontend/src/login/challenge_login_page.dart';
import 'package:frontend/src/login/find_voucher_page.dart';

import 'package:frontend/src/login/main_login_page.dart';

import 'package:frontend/src/graphic_charter.dart';

/// The Widget that configures your application.
class Valide extends StatelessWidget {
  const Valide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenWidth < screenHeight;
    double minDim = isPortrait ? screenWidth : screenHeight;
    double maxDim = isPortrait ? screenHeight : screenWidth;

    var buttonFontSize = minDim * 0.05;

    return MaterialApp(
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'root',

      // Provide the generated AppLocalizations to the MaterialApp. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('fr', ''), // French, no country code
      ],

      // Use AppLocalizations to configure the correct application title
      // depending on the user's locale.
      //
      // The appTitle is defined in .arb files found in the localization
      // directory.
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,

      // Define a theme.
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            // letterSpacing: 0.8,
          ),
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        //
        //
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          centerTitle: true,
          // titleTextStyle: TextStyle(
          //   color: Colors.black,
          //   fontSize: 25,
          //   fontWeight: FontWeight.bold,
          //   letterSpacing: 0.8,
          // ),
          iconTheme: IconThemeData(
            color: Colors.black,
            size: 31,
          ),
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: pink, // Transparent background
              foregroundColor: Colors.white, // Text color
              disabledForegroundColor: Colors.grey,
              disabledBackgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
              minimumSize: Size(minDim * 0.75, 0),
              maximumSize: Size(minDim * 0.75, maxDim),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              textStyle: TextStyle(
                fontSize: buttonFontSize,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              )),
        ),
//
//
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: Colors.transparent, // Transparent background
              foregroundColor: pink, // Text color
              disabledForegroundColor: Color.fromARGB(255, 212, 212, 212),
              disabledBackgroundColor: Colors.transparent,
              minimumSize: Size(minDim * 0.75, 0),
              maximumSize: Size(minDim * 0.75, maxDim),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              textStyle: TextStyle(
                fontSize: buttonFontSize,
                fontWeight: FontWeight.w500,
                color: pink,
              )),
        ),
//
//
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: pink,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: pink,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: gold,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          labelStyle: TextStyle(
              color: pink,
              fontSize: buttonFontSize,
              fontWeight: FontWeight.w400),
          hintStyle: TextStyle(
              color: pink,
              fontSize: buttonFontSize,
              fontWeight: FontWeight.w200),
          errorStyle: TextStyle(
              color: Colors.red,
              fontSize: buttonFontSize * 0.75,
              fontWeight: FontWeight.w400),
        ),
      ),

      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            {
              switch (routeSettings.name) {
                case "/login/phone":
                  return const LoginPage();
                case "/login/challenge":
                  return const ChallengeLoginPage();
                case "/account/voucher/find":
                  return const FindVoucherPage();
                default:
                  return const MainLoginPage();
              }
            }
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/src/login/email_login_page.dart';
import 'package:frontend/src/login/challenge_login_page.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

import 'managers/credentials_manager.dart';
import 'managers/backend_manager.dart';

import 'login/main_login_page.dart';

/// The Widget that configures your application.
class Valide extends StatelessWidget {
  const Valide({
    super.key,
    required this.settingsController,
    required this.credentialsManager,
    required this.backendManager,
  });

  final SettingsController settingsController;
  final CredentialsManager credentialsManager;
  final BackendManager backendManager;

  @override
  Widget build(BuildContext context) {
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
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 222, 184, 65)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                fontSize: 30.0,
              ),
            ),
          ),
        ),
      ),

      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            if (!credentialsManager.isUserConnected()) {
              switch (routeSettings.name) {
                case SettingsView.routeName:
                  return SettingsView(controller: settingsController);
                case SampleItemDetailsView.routeName:
                  return const SampleItemDetailsView();
                case SampleItemListView.routeName:
                default:
                  return const SampleItemListView();
              }
            } else {
              print(routeSettings.name);
              switch (routeSettings.name) {
                case "/login/email":
                  return EmailLoginPage(
                      credentialsManager: credentialsManager,
                      backendManager: backendManager);
                case "/login/challenge":
                  return ChallengeLoginPage(
                      credentialsManager: credentialsManager,
                      backendManager: backendManager);
                default:
                  return MainLoginPage(
                    credentialsManager: credentialsManager,
                    backendManager: backendManager,
                  );
              }
            }
          },
        );
      },
    );
  }
}

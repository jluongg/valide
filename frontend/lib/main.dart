import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'src/valide.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'src/providers/backend.dart';
import 'package:supertokens_flutter/supertokens.dart';

const backend_url =
    '192.168.20.245:8080'; // This should be the ip of the machine on which the real device is connected (the inet part of ifconfig command) for the debug phase

void main() async {
  // SuperTokens initialization
  WidgetsFlutterBinding.ensureInitialized();
  SuperTokens.init(
    apiDomain: "http://$backend_url",
    apiBasePath: "/auth",
  );

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  // to delete
  await settingsController.loadSettings();

  WidgetsFlutterBinding.ensureInitialized();

  // Lock the orientation to portrait mode only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (context) => Backend(baseUrl: backend_url)),
    ], child: const Valide()));
  });
}

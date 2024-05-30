import 'package:flutter/material.dart';

import 'src/valide.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'src/managers/credentials_manager.dart';
import 'src/managers/backend_manager.dart';
import 'package:supertokens_flutter/supertokens.dart';

void main() async {
  // SuperTokens initialization
  SuperTokens.init(
    apiDomain: "192.168.35.51:8080",
    apiBasePath: "/auth",
  );

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  // to delete
  await settingsController.loadSettings();

  // Load the user's saved credentials while the splash screen is displayed.
  final credentialsManager = CredentialsManager();
  await credentialsManager.loadCredentials();

  // Create the backend manager.
  final backendManager = BackendManager();

  // Run the app and pass in the CredentialsManager.
  runApp(Valide(
      settingsController: settingsController,
      credentialsManager: credentialsManager,
      backendManager: backendManager));
}

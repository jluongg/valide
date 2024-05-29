import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../managers/backend_manager.dart';
import '../managers/credentials_manager.dart';

/// Main login page with a button connection.
class MainLoginPage extends StatelessWidget {
  const MainLoginPage({
    super.key,
    required this.credentialsManager,
    required this.backendManager,
  });

  final CredentialsManager credentialsManager;
  final BackendManager backendManager;
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            const Image(
                image: AssetImage("assets/images/logo.png"),
                width: 150,
                height: 150),
            SizedBox(height: 300),
            TextButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/login/email');
              },
              child: Text(
                AppLocalizations.of(context)!.emailLoginButton,
              ),
            )
          ],
        ),
      ),
    );
  }
}

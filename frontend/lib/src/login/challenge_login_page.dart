import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:email_validator/email_validator.dart';

import '../managers/backend_manager.dart';
import '../managers/credentials_manager.dart';

/// Main login page with a button connection.
class ChallengeLoginPage extends StatelessWidget {
  const ChallengeLoginPage({
    super.key,
    required this.credentialsManager,
    required this.backendManager,
  });

  final CredentialsManager credentialsManager;
  final BackendManager backendManager;
  static const routeName = '/login/challenge';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Image(
                image: AssetImage("assets/images/logo.png"),
                width: 150,
                height: 150),
            SizedBox(height: 50),
            ChallengeForm(),
          ],
        ),
      ),
    );
  }
}

// Define a custom Form widget.
class ChallengeForm extends StatefulWidget {
  const ChallengeForm({super.key});

  @override
  ChallengeFormState createState() {
    return ChallengeFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class ChallengeFormState extends State<ChallengeForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            onChanged: (value) => setState(() {}),
            validator: (value) => EmailValidator.validate(value!)
                ? null
                : AppLocalizations.of(context)!.please_enter_valid_email,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: AppLocalizations.of(context)!.password,
              hintText: AppLocalizations.of(context)!.enter_password,
              prefixIcon: Icon(Icons.password),
            ),
          ),
          SizedBox(height: 50),
          TextButton(
            onPressed: (_formKey.currentState != null &&
                    _formKey.currentState!.validate())
                ? () async {
                    Navigator.pushNamed(context, '/login/challenge');
                  }
                : null,
            child: Text(
              AppLocalizations.of(context)!.verify_code,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:email_validator/email_validator.dart';

import '../managers/backend_manager.dart';
import '../managers/credentials_manager.dart';

/// Main login page with a button connection.
class EmailLoginPage extends StatelessWidget {
  const EmailLoginPage({
    super.key,
    required this.credentialsManager,
    required this.backendManager,
  });

  final CredentialsManager credentialsManager;
  final BackendManager backendManager;
  static const routeName = '/login/email';

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
            MailForm(),
          ],
        ),
      ),
    );
  }
}

// Define a custom Form widget.
class MailForm extends StatefulWidget {
  const MailForm({super.key});

  @override
  MailFormState createState() {
    return MailFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MailFormState extends State<MailForm> {
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
              labelText: AppLocalizations.of(context)!.email,
              hintText: AppLocalizations.of(context)!.enter_email,
              prefixIcon: Icon(Icons.email),
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
              AppLocalizations.of(context)!.login,
            ),
          ),
        ],
      ),
    );
  }
}

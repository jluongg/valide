import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/src/providers/backend.dart';
import 'package:provider/provider.dart';
import 'package:frontend/src/widgets/outer_padding.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:frontend/src/graphic_charter.dart';

/// Main login page with a button connection.
class ChallengeLoginPage extends StatelessWidget {
  const ChallengeLoginPage({
    super.key,
  });

  static const routeName = '/login/challenge';

  @override
  Widget build(BuildContext context) {
    // Retrieve the argument passed using ModalRoute
    final Map<String, String>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    return Scaffold(
      appBar: AppBar(),
      body: OuterPadding(
        child: Center(
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.challenge_page_title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(flex: 1),
              Flexible(
                flex: 3,
                child: ChallengeForm(args: args),
              ),
              const Spacer(flex: 1),
              Text.rich(
                TextSpan(
                    text: AppLocalizations.of(context)!
                        .challenge_page_code_sent_to,
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: args?["phoneNumber"],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ]),
              ),
              const SizedBox(height: 20),
              const ResendButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class ResendButton extends StatefulWidget {
  const ResendButton({
    super.key,
  });

  @override
  State<ResendButton> createState() => _ResendButtonState();
}

class _ResendButtonState extends State<ResendButton> {
  var _enabledButton = true;
  var _cooldown = 2;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _enabledButton
          ? () async {
              if (context.mounted) {
                setState(() {
                  _enabledButton = false;
                  _cooldown *= 2;
                });

                var response =
                    await Provider.of<Backend>(context, listen: false)
                        .signinupResendCode();
                if (response != null && response.statusCode == 200) {
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          AppLocalizations.of(context)!.connection_error)));
                }
                Future.delayed(Duration(seconds: _cooldown), () {
                  setState(() {
                    _enabledButton = true; // Enable the button again
                  });
                });
              }
            }
          : null,
      child: Text(
        AppLocalizations.of(context)!.challenge_page_send_again,
      ),
    );
  }
}

// Define a custom Form widget.
class ChallengeForm extends StatefulWidget {
  final Map<String, String>? args;

  const ChallengeForm({super.key, required this.args});

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
  final _controller = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: PinFieldAutoFill(
        cursor: null,
        enableInteractiveSelection: false,
        autoFocus: true,
        decoration: BoxLooseDecoration(
          strokeColorBuilder: PinListenColorBuilder(gold, pink),
          radius: const Radius.circular(20),
          strokeWidth: 2,
          gapSpace: 10,
        ),
        onCodeChanged: (text) async {
          if (text?.length == 6) {
            var response = await Provider.of<Backend>(context, listen: false)
                .signinupConsumeCode(text!);
            if (context.mounted) {
              if (response != null && response.statusCode == 200) {
                Map<String, dynamic> response_json = jsonDecode(response.body);
                if (response_json["status"].toString() == "OK" &&
                    response_json["createdNewUser"] == true) {
                  Navigator.pushNamed(context, '/account/voucher/find');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text(AppLocalizations.of(context)!.login_failed)));
                  Navigator.popAndPushNamed(context, '/login/challenge',
                      arguments: widget.args);
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text(AppLocalizations.of(context)!.connection_error)));
              }
            }
          }
        },
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/src/providers/backend.dart';
import 'package:provider/provider.dart';
import 'package:frontend/src/widgets/outer_padding.dart';
// import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
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
              const Flexible(
                flex: 5,
                child: ChallengeForm(),
              ),
            ],
          ),
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
      child: Column(
        children: [
          PinFieldAutoFill(
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
                Navigator.pushNamed(context, '/login/phone');
                var response =
                    await Provider.of<Backend>(context, listen: false)
                        .signinupConsumeCode(text!);
                print(response);
                print(response?.statusCode);
                if (response != null && response.statusCode == 200) {
                  var response_json = jsonDecode(response.body);
                  if (response_json["status"] == "OK" &&
                      response_json["createdNewUser"]) {
                    Navigator.pushNamed(context, '/account/voucher/find');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text(AppLocalizations.of(context)!.login_failed)));
                    Navigator.popAndPushNamed(context, '/login/challenge');
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          AppLocalizations.of(context)!.connection_error)));
                }
              }
            },
          ),
          // Theme(
          //   data: ThemeData(),
          //   child: PinCodeFields(
          //     fieldBorderStyle: FieldBorderStyle.square,
          //     fieldHeight: 60.0,
          //     borderColor: pink,
          //     borderRadius: BorderRadius.circular(20.0),
          //     activeBorderColor: gold,
          //     length: 6,
          //     keyboardType: TextInputType.number,
          //     autofocus: true,
          //     onComplete: (text) async {
          //       var response =
          //           await Provider.of<Backend>(context, listen: false)
          //               .signinupConsumeCode(text);
          //       print(response);
          //       print(response?.statusCode);
          //       if (context.mounted) {
          //         if (response != null && response.statusCode == 200) {
          //           var responseJson = jsonDecode(response.body);
          //           if (responseJson["status"] == "OK" &&
          //               responseJson["createdNewUser"]) {
          //             Navigator.pushNamed(context, '/account/voucher/find');
          //           } else {
          //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //                 content: Text(
          //                     AppLocalizations.of(context)!.login_failed)));
          //             Navigator.popAndPushNamed(context, '/login/challenge');
          //           }
          //         } else {
          //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //               content: Text(
          //                   AppLocalizations.of(context)!.connection_error)));
          //         }
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/src/widgets/outer_padding.dart';
import 'package:frontend/src/providers/backend.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

/// Input page for phone number.
class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });
  static const routeName = '/login/phone';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: OuterPadding(
        child: Center(
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.login_page_title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(flex: 1),
              const Flexible(
                flex: 5,
                child: PhoneForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Define a custom Form widget.
class PhoneForm extends StatefulWidget {
  const PhoneForm({super.key});

  @override
  PhoneFormState createState() {
    return PhoneFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class PhoneFormState extends State<PhoneForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  String completePhoneNumber = '';
  final _controller = TextEditingController();
  var _buttonEnabled = true;
  FocusNode focusNode = FocusNode();

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
          IntlPhoneField(
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.enter_phone_number,
            ),
            pickerDialogStyle: PickerDialogStyle(
              searchFieldInputDecoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.search_country,
              ),
            ),
            initialCountryCode: AppLocalizations.of(context)!.country_code,
            languageCode: Localizations.localeOf(context).languageCode,
            invalidNumberMessage:
                AppLocalizations.of(context)!.please_enter_valid_phone_number,
            onChanged: (phone) {
              setState(() {
                completePhoneNumber = phone.completeNumber;
              });
            },
          ),
          const SizedBox(height: 50),
          FilledButton(
            onPressed: (_buttonEnabled &&
                    _formKey.currentState != null &&
                    _formKey.currentState!.validate())
                ? () async {
                    setState(() {
                      _buttonEnabled = false;
                    });
                    var signature = await SmsAutoFill().getAppSignature;
                    print("App signature : ");
                    print(signature);
                    if (context.mounted) {
                      var response =
                          await Provider.of<Backend>(context, listen: false)
                              .signinupSubmitEmail(context, _controller.text);
                      if (context.mounted) {
                        if (response != null) {
                          Map<String, String> args = {
                            "phoneNumber": completePhoneNumber,
                          };
                          Navigator.pushNamed(
                            context,
                            '/login/challenge',
                            arguments: args,
                          );
                        }
                      }
                    }
                    setState(() {
                      _buttonEnabled = true;
                    });
                  }
                : null,
            child: Text(
              AppLocalizations.of(context)!.login,
            ),
          ),
          const Spacer(
            flex: 10,
          ),
          TextFormField(
            onChanged: (value) => setState(() {}),
            controller: _controller,
            decoration: const InputDecoration(
              labelText: "email",
              hintText: "email temporaire",
              prefixIcon: Icon(Icons.email),
            ),
          ),
        ],
      ),
    );
  }
}

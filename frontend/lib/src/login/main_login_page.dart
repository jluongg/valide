import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/src/widgets/outer_padding.dart';
import 'package:frontend/src/widgets/link.dart';

/// Main login page with a button connection.
class MainLoginPage extends StatelessWidget {
  const MainLoginPage({
    super.key,
  });

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OuterPadding(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(50.0),
                child: Image(
                    image: AssetImage("assets/images/logo.png"),
                    width: 150,
                    height: 150),
              ),
              const Spacer(flex: 5),
              Column(
                children: [
                  FilledButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, '/login/phone');
                    },
                    child: Text(
                      AppLocalizations.of(context)!.phoneLoginButton,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 1),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.cgu_text,
                      textAlign: TextAlign.center,
                    ),
                    Link(
                        text: AppLocalizations.of(context)!.cgu_link_text,
                        url: AppLocalizations.of(context)!.cgu_url),
                    Link(
                        text: AppLocalizations.of(context)!
                            .pol_confidentialite_link_text,
                        url: AppLocalizations.of(context)!
                            .pol_confidentialite_url),
                    Link(
                        text: AppLocalizations.of(context)!.cookies_link_text,
                        url: AppLocalizations.of(context)!.cookies_url),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

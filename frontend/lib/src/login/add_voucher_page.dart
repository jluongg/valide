import 'package:flutter/material.dart';
import 'package:frontend/src/widgets/outer_padding.dart';
// import 'package:frontend/src/providers/backend.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Input page for voucher.
class AddVoucherPage extends StatelessWidget {
  const AddVoucherPage({
    super.key,
  });

  static const routeName = '/account/voucher/add';

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
                child: Placeholder(),
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
              const Placeholder(),
            ],
          ),
        ),
      ),
    );
  }
}

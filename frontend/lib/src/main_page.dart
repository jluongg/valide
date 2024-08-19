import 'package:flutter/material.dart';

import 'package:frontend/src/widgets/outer_padding.dart';

/// Input page for phone number.
class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });
  static const routeName = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: OuterPadding(
        child: Center(
          child: Column(
            children: [
              Text(
                "main page",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

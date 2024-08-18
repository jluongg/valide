import 'package:flutter/material.dart';

/// Main login page with a button connection.
class FindVoucherPage extends StatelessWidget {
  const FindVoucherPage({
    super.key,
  });

  static const routeName = '/account/voucher/find';

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
          ],
        ),
      ),
    );
  }
}

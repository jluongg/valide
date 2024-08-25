import 'package:flutter/material.dart';
import 'package:supertokens_flutter/supertokens.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Call the Future action after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 5));
      bool sessionExists = await SuperTokens.doesSessionExist();
      if (sessionExists) {
        Navigator.pushReplacementNamed(
          context,
          '/main',
        );
      } else {
        // Failure, navigate to FailurePage
        Navigator.pushReplacementNamed(
          context,
          '/login',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/splash.json',
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}

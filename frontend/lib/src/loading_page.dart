import 'package:flutter/material.dart';
import 'package:supertokens_flutter/supertokens.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();

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
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedLogo(controller: _controller!),
      ),
    );
  }
}

// Animated logo widget
class AnimatedLogo extends StatelessWidget {
  final AnimationController controller;

  AnimatedLogo({required this.controller});

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: controller,
      child: FlutterLogo(size: 100),
    );
  }
}

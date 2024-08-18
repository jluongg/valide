import 'package:flutter/material.dart';

class OuterPadding extends StatelessWidget {
  final Widget child;

  const OuterPadding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenWidth < screenHeight;
    double minDim = isPortrait ? screenWidth : screenHeight;

    return Padding(
      padding: EdgeInsets.all(minDim * 0.03),
      child: child,
    );
  }
}

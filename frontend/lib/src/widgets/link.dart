import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Link extends StatelessWidget {
  final String text;
  final String url;

  const Link({super.key, required this.text, required this.url});

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchUrl,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blue,
          decorationColor: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

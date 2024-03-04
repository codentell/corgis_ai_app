import 'package:corgis_ai_app/pages/welcome/screen/intro.dart';
import 'package:corgis_ai_app/pages/welcome/screen/onboard.dart';
import 'package:flutter/material.dart';
import 'package:corgis_ai_app/pages/welcome/screen/hello.dart';

class WelcomePage extends StatefulWidget {
  final String id;
  const WelcomePage({super.key, required this.id});

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final String id = widget.id;

    if (id == "0") {
      return const IntroPage();
    } else if (id == "1") {
      return const HelloPage();
    } else if (id == "2") {
      return const OnboardPage();
    } else {
      return Container(color: Colors.green);
    }
  }
}

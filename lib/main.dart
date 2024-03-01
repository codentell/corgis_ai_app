import 'package:flutter/material.dart';
import 'package:corgis_ai_app/pages/start_page.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

void main() async {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    hideScreen();
  }

  Future<void> hideScreen() async {
    Future.delayed(const Duration(milliseconds: 6000), () {
      FlutterSplashScreen.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'corgis.ai',
      initialRoute: "/start",
      routes: {
        "/start": (context) => const StartPage(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:corgis_ai_app/pages/start_page.dart';
import 'package:corgis_ai_app/pages/start_page.dart';

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

import 'package:corgis_ai_app/pages/pricing_page.dart';
import 'package:corgis_ai_app/pages/signup_page.dart';
import 'package:corgis_ai_app/pages/subscribe_page.dart';
import 'package:flutter/material.dart';
import 'package:corgis_ai_app/pages/start_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:corgis_ai_app/pages/login_page.dart';
import 'package:corgis_ai_app/pages/home_page.dart';
import 'package:corgis_ai_app/pages/welcome/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'store_config.dart';
import 'package:corgis_ai_app/constants/revenue_cat.dart';
import 'dart:io';

void main() async {
  if (Platform.isIOS || Platform.isMacOS) {
    StoreConfig(
      store: Store.appStore,
      apiKey: appleApiKey,
    );
  }

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await Supabase.initialize(
    url: 'https://drurtwyuweespqltqbyw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRydXJ0d3l1d2Vlc3BxbHRxYnl3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc2MTc2NDYsImV4cCI6MjAxMzE5MzY0Nn0.fcXOeXkuOkTCClMyj8zxbbDNXMGXCt6XVDGDiRfR8Ec',
    debug: true,
    //authFlowType: AuthFlowType.pkce,
  );

  await revenueCatConfigure();
  runApp(const App());
}

final supabase = Supabase.instance.client;

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  User? _user;
  bool isLogin = false;

  Future<void> getAuth() async {
    setState(() {
      _user = Supabase.instance.client.auth.currentUser;
    });
    Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      setState(() {
        _user = data.session?.user;
      });
      //if (data.event == AuthChangeEvent.signedIn) {}

      print('User: $_user');
    });

    // FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
    //   await setFcmToken(fcmToken);
    // });
  }

  @override
  void initState() {
    getAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'corgis.ai',
      initialRoute: _user == null ? '/start' : '/home',
      routes: {
        "/signup": (context) => const SignupPage(),
        "/login": (context) => const LoginPage(),
        "/start": (context) => const StartPage(),
        "/home": (context) => const HomePage(),
        "/subscribe": (context) => const SubscribePage(),
        "/pricing": (context) => const PricingPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final Uri uri = Uri.parse(settings.name!);
        final List<String> pathSegments = uri.pathSegments;

        // Check if the path is the dynamic welcome path
        if (pathSegments.length == 2 && pathSegments.first == 'welcome') {
          final String id = pathSegments[1];
          // Return the MaterialPageRoute for the WelcomePage with the extracted ID
          print('id: $id');
          return MaterialPageRoute(
            builder: (context) => WelcomePage(id: id),
            settings: settings,
          );
        }

        // Return null for any routes that are not handled
        return null;
      },
    );
  }
}

Future<void> revenueCatConfigure() async {
  // Enable debug logs before calling `configure`.
  await Purchases.setLogLevel(LogLevel.debug);

  PurchasesConfiguration configuration;

  configuration = PurchasesConfiguration('appl_phOPDTrJBFYlHQpljdQKJziYFjv');
  if (configuration != null) {
    await Purchases.configure(configuration);
  }
}

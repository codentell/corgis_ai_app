import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:corgis_ai_app/components/TyperAnimatedTextCustom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:corgis_ai_app/main.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isEmailValid = false;
  late final emailController = TextEditingController();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  late final StreamSubscription<AuthState> authStateSubscription;
  bool redirecting = false;
  @override
  void initState() {
    setupAuthListener();

    super.initState();
  }

  Future<void> setFcmToken(String fcmToken) async {
    final userId = supabase.auth.currentUser?.id;

    final email = supabase.auth.currentUser?.email ?? "";
    final username = email.split('@')[0];
    print('userId: $userId');
    print('fcmToken: $fcmToken');
    await supabase
        .from('profiles')
        .upsert({'id': userId, 'fcm_token': fcmToken, 'username': username});
  }

  void setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) async {
      final event = data.event;

      if (event == AuthChangeEvent.signedIn) {
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.getAPNSToken();
        final fcmToken = await FirebaseMessaging.instance.getToken();
        print(fcmToken);
        if (fcmToken != null) {
          await setFcmToken(fcmToken);
        }
        Navigator.of(context).pushNamed('/home');
      }
      if (redirecting) return;
      final session = data.session;
      if (session != null) {
        redirecting = true;
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  Future<AuthResponse> _googleSignIn() async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '994572789648-u45a7dg4lija8o3q4dr52k6lufhrfrkg.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId =
        '994572789648-2htlj9q9h7h8j81164klf3ddstquvcur.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('isLogin', true);

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<void> login() async {
    print(emailController.text);
    try {
      setState(() {
        isLoading = true;
      });

      await supabase.auth.signInWithOtp(
        email: emailController.text.trim(),
        emailRedirectTo:
            kIsWeb ? null : 'io.supabase.codewithcorgis://login-callback/',
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Check your email for a login link!')),
        );
        emailController.clear();
      }
    } on AuthException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFF0A062F),
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Container(
                height: 70,
                color: const Color(0xFF0A062F),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 50,
                        height: 50,
                        color: const Color(0xFF0A062F),
                        child: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () => {Navigator.pop(context, true)})),
                    const Expanded(
                        flex: 5,
                        child: SizedBox(
                          width: 200,
                          height: 20,
                        )),
                    Container(
                      width: 50,
                      height: 50,
                      color: const Color(0xFF0A062F),
                    ),
                  ],
                ),
              )),
          body: SingleChildScrollView(
              child: Container(
                  width: 500,
                  child: Center(
                      child: SizedBox(
                          width: 500,
                          height: 650,
                          child: Stack(children: [
                            const RiveAnimation.network(
                              "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/login.riv",
                              fit: BoxFit.contain,
                              animations: ['idle'],
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 40, right: 40, top: 60),
                                height: 450,
                                width: 500,
                                color: Colors.transparent,
                                child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: CustomAnimationBuilder<double>(
                                              tween: Tween<double>(
                                                  begin: 0.0, end: 1.0),
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              builder: (context, value, child) {
                                                return Transform.scale(
                                                    scale: value,
                                                    child: Form(
                                                        key: formKey,
                                                        child: Column(
                                                            children: [
                                                              SizedBox(
                                                                  height: 70,
                                                                  width: 500,
                                                                  child: TextFormField(
                                                                      cursorWidth: 4,
                                                                      cursorColor: const Color(0xFF5F5DEF),
                                                                      style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20,
                                                                        fontFamily:
                                                                            'Eina',
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      keyboardType: TextInputType.emailAddress,
                                                                      autofillHints: const [AutofillHints.email],
                                                                      onChanged: (value) {
                                                                        if (value
                                                                            .isNotEmpty) {
                                                                          if (EmailValidator.validate(
                                                                              value)) {
                                                                            setState(() {
                                                                              isEmailValid = true;
                                                                            });
                                                                          } else {
                                                                            setState(() {
                                                                              isEmailValid = false;
                                                                            });
                                                                          }
                                                                        }
                                                                      },
                                                                      validator: (value) {
                                                                        print(
                                                                            value);
                                                                        print(emailController
                                                                            .text);
                                                                        if (value ==
                                                                                null ||
                                                                            value.isEmpty ||
                                                                            !EmailValidator.validate(emailController.text)) {
                                                                          return 'Please enter a valid email address';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      decoration: InputDecoration(
                                                                          focusedBorder: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.0),
                                                                            borderSide:
                                                                                const BorderSide(
                                                                              color: Color(0xFF5F5DEF),
                                                                              width: 4.0,
                                                                            ),
                                                                          ),
                                                                          enabledBorder: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.0),
                                                                            borderSide:
                                                                                const BorderSide(
                                                                              color: Color(0xFF5F5DEF),
                                                                              width: 4.0,
                                                                            ),
                                                                          ),
                                                                          border: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(16),
                                                                          ),
                                                                          hintStyle: const TextStyle(fontFamily: 'Eina', fontSize: 18, color: Colors.white),
                                                                          prefixIcon: const Icon(Icons.email, color: Colors.white),
                                                                          hintText: 'Enter an email address'),
                                                                      controller: emailController))
                                                            ])));
                                              })),

                                      Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  login();
                                                }
                                                // if (emailController.text.isNotEmpty) {
                                                //   if (EmailValidator.validate(
                                                //       emailController.text)) {
                                                //     setState(() {
                                                //       isEmailValid = true;
                                                //     });
                                                //   } else {
                                                //     setState(() {
                                                //       isEmailValid = false;
                                                //     });
                                                //   }
                                                // }
                                                // if (isEmailValid) {
                                                //   login();
                                                // }
                                              },
                                              child: CustomAnimationBuilder<
                                                      double>(
                                                  // control:
                                                  //     control, // bind variable with control instruction
                                                  tween: Tween<double>(
                                                      begin: 0.0, end: 1.0),
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  builder:
                                                      (context, value, child) {
                                                    return Transform.scale(
                                                        scale: value,
                                                        child: Column(
                                                            children: [
                                                              Container(
                                                                  height: 50,
                                                                  width: 500,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: !isEmailValid
                                                                              ? const Color(
                                                                                  0xFF202F36)
                                                                              : Color(
                                                                                  0xFFA2FF66),
                                                                          borderRadius: BorderRadius
                                                                              .only(
                                                                            topRight:
                                                                                Radius.circular(10),
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                          )),
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        !isEmailValid
                                                                            ? Container(
                                                                                width: 30,
                                                                                height: 30,
                                                                                child: RiveAnimation.asset(
                                                                                  'assets/images/icons/lock.riv',
                                                                                  animations: const [
                                                                                    'idle'
                                                                                  ],
                                                                                  fit: BoxFit.contain,
                                                                                ))
                                                                            : Container(),
                                                                        Container(
                                                                          margin: const EdgeInsets
                                                                              .only(
                                                                              left: 5),
                                                                          child: isLoading
                                                                              ? CircularProgressIndicator(
                                                                                  strokeWidth: 4,
                                                                                  valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF1a1e4c)),
                                                                                )
                                                                              : Text(
                                                                                  "login",
                                                                                  style: TextStyle(
                                                                                    color: !isEmailValid ? const Color(0xFF49C1F9) : Color(0xFF1a1e4c),
                                                                                    fontSize: 21,
                                                                                    fontFamily: 'Eina',
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                        )
                                                                      ])),
                                                              Container(
                                                                height: 15,
                                                                width: 500,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        border: Border
                                                                            .all(
                                                                          color: !isEmailValid
                                                                              ? const Color(0xFF384650)
                                                                              : const Color(0xFF69EC15),
                                                                          width:
                                                                              3,
                                                                        ),
                                                                        borderRadius:
                                                                            const BorderRadius
                                                                                .only(
                                                                          bottomRight:
                                                                              Radius.circular(10),
                                                                          bottomLeft:
                                                                              Radius.circular(10),
                                                                        ),
                                                                        color: !isEmailValid
                                                                            ? const Color(0xFF384650)
                                                                            : const Color(0xFF69EC15)),
                                                              ),
                                                            ]));
                                                  }))),

                                      Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Container(
                                            height: 40,
                                            child: Center(
                                                child: Text("or",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 21,
                                                      fontFamily: 'Eina',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ))),
                                          )),
                                      // Row(children: [
                                      Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: GestureDetector(
                                              onTap: () {
                                                _googleSignIn();
                                              },
                                              child: CustomAnimationBuilder<
                                                      double>(
                                                  // control:
                                                  //     control, // bind variable with control instruction
                                                  tween: Tween<double>(
                                                      begin: 0.0, end: 1.0),
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  builder:
                                                      (context, value, child) {
                                                    return Transform.scale(
                                                        scale: value,
                                                        child: Column(
                                                            children: [
                                                              Container(
                                                                  height: 50,
                                                                  width: 500,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius: BorderRadius
                                                                              .only(
                                                                            topRight:
                                                                                Radius.circular(10),
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                          )),
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                            width:
                                                                                30,
                                                                            height:
                                                                                30,
                                                                            child:
                                                                                RiveAnimation.asset(
                                                                              'assets/images/icons/google.riv',
                                                                              animations: const [
                                                                                'idle'
                                                                              ],
                                                                              fit: BoxFit.contain,
                                                                            )),
                                                                        Container(
                                                                          margin: const EdgeInsets
                                                                              .only(
                                                                              left: 5),
                                                                          child:
                                                                              Text(
                                                                            "Google",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color(0xFF1a1e4c),
                                                                              fontSize: 21,
                                                                              fontFamily: 'Eina',
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ])),
                                                              Container(
                                                                height: 15,
                                                                width: MediaQuery.of(context)
                                                                            .size
                                                                            .width <
                                                                        500
                                                                    ? 400
                                                                    : 500,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            235,
                                                                            235,
                                                                            235),
                                                                    width: 3,
                                                                  ),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                  ),
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          235,
                                                                          235,
                                                                          235),
                                                                ),
                                                              ),
                                                            ]));
                                                  }))),

                                      Expanded(
                                          child: GestureDetector(
                                              onTap: () {
                                                //_googleSignIn();
                                              },
                                              child:
                                                  CustomAnimationBuilder<
                                                          double>(
                                                      tween: Tween<double>(
                                                          begin: 0.0, end: 1.0),
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      builder: (context, value,
                                                          child) {
                                                        return Transform.scale(
                                                            scale: value,
                                                            child: Column(
                                                                children: [
                                                                  Container(
                                                                      height:
                                                                          50,
                                                                      width: MediaQuery.of(context).size.width <
                                                                              500
                                                                          ? 400
                                                                          : 500,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                              color: Colors
                                                                                  .white,
                                                                              borderRadius: BorderRadius
                                                                                  .only(
                                                                                topRight: Radius.circular(10),
                                                                                topLeft: Radius.circular(10),
                                                                              )),
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                                width: 30,
                                                                                height: 30,
                                                                                child: RiveAnimation.asset(
                                                                                  'assets/images/icons/apple.riv',
                                                                                  animations: const [
                                                                                    'idle'
                                                                                  ],
                                                                                  fit: BoxFit.contain,
                                                                                )),
                                                                            Container(
                                                                              margin: const EdgeInsets.only(left: 5),
                                                                              child: Text(
                                                                                "Apple",
                                                                                style: TextStyle(
                                                                                  color: Color(0xFF1a1e4c),
                                                                                  fontSize: 21,
                                                                                  fontFamily: 'Eina',
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ])),
                                                                  Container(
                                                                    height: 15,
                                                                    width: 500,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            235,
                                                                            235,
                                                                            235),
                                                                        width:
                                                                            3,
                                                                      ),
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .only(
                                                                        bottomRight:
                                                                            Radius.circular(10),
                                                                        bottomLeft:
                                                                            Radius.circular(10),
                                                                      ),
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          235,
                                                                          235,
                                                                          235),
                                                                    ),
                                                                  ),
                                                                ]));
                                                      }))),
                                      //]),
                                      Container(
                                          color: Colors.transparent,
                                          child: Row(children: [
                                            Expanded(child: Container()),
                                            Expanded(
                                                child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: const Color(
                                                    0xFF0E0657), //(0xFF0E0657),
                                                border: Border.all(
                                                  color: Colors
                                                      .white, //const Color(0xFF5046E4),
                                                  width: 4,
                                                ),
                                                //color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: AnimatedTextKit(
                                                totalRepeatCount: 1,
                                                animatedTexts: [
                                                  TyperAnimatedTextCustom(
                                                    [
                                                      const TextSpan(
                                                        text: "No account? ",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontFamily: 'Eina',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: "Sign up",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontFamily: 'Eina',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap =
                                                                  () => {
                                                                        Navigator.of(context)
                                                                            .pushNamed('/welcome/1')
                                                                      },
                                                      ),
                                                    ],
                                                    speed: const Duration(
                                                        milliseconds: 50),
                                                  )
                                                ],
                                              ),
                                            ))
                                          ]))
                                    ])),
                          ])))))),
    );
  }
}

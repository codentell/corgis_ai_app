import 'package:flutter/foundation.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:corgis_ai_app/components/TyperAnimatedTextCustom.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:corgis_ai_app/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rive/rive.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  late int panelIndex;
  late int page;
  late bool isLocked = true;
  late String username = "";
  late bool isAuthenticating;
  ScrollController scrollController = new ScrollController();
  final PageController pageController = PageController();
  late bool selectGoogleSignIn;
  bool isEmailValid = false;
  late final emailController = TextEditingController();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    setState(() {
      page = 0;
      panelIndex = 0;

      selectGoogleSignIn = false;
      isAuthenticating = false;
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLocked = false;
      });
    });

    setupAuthListener();
    super.initState();
  }

  Future<void> setFcmToken(String fcmToken) async {
    final userId = supabase.auth.currentUser?.id;
    final email = supabase.auth.currentUser?.email ?? "";
    final username = email.split('@')[0];
    print('userId: $userId');
    print('fcmToken: $fcmToken');
    await supabase.from('profiles').upsert({
      'id': userId,
      'fcm_token': fcmToken,
      'username': username,
    });
  }

  Future<void> login() async {
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

  void setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) async {
      final event = data.event;

      if (event == AuthChangeEvent.signedIn) {
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.getAPNSToken();
        final fcmToken = await FirebaseMessaging.instance.getToken();
        //print(fcmToken);

        if (fcmToken != null) {
          await setFcmToken(fcmToken);
          var email = supabase.auth.currentUser?.email ?? "@[email]";

          setState(() {
            isAuthenticating = true;
            username = email.split("@")[0];
          });
        }
        if (isAuthenticating) {
          setState(() {
            page += 1;
            panelIndex = 0;
            isLocked = true;
          });
          //print("page$page");
          pageController.animateToPage(page,
              duration: const Duration(milliseconds: 3000),
              curve: Curves.easeInOut);
        }
        // Navigator.of(context).pushNamed('/home');
      }
      // if (redirecting) return;
      // final session = data.session;
      // if (session != null) {
      //   redirecting = true;
      //   Navigator.of(context).pushReplacementNamed('/home');
      // }
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

    // SharedPreferences sp = await SharedPreferences.getInstance();
    // sp.setBool('isLogin', true);

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: Container(
                  height: 70,
                  color: isLocked
                      ? const Color(0xFF1B282E)
                      : const Color(0xFF0A062F),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          color: isLocked
                              ? const Color(0xFF1B282E)
                              : const Color(0xFF0A062F),
                          child: IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                              onPressed: () => {
                                    if (page == 0)
                                      {Navigator.pop(context, true)}
                                    else
                                      {
                                        pageController.animateToPage(page - 1,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeInOut),
                                        setState(() {
                                          page -= 1;
                                          panelIndex = 0;
                                        })
                                      }
                                  })),
                      const Expanded(
                          flex: 5,
                          child: SizedBox(
                            width: 200,
                            height: 20,
                          )),
                      Container(
                        width: 50,
                        height: 50,
                        color: isLocked
                            ? const Color(0xFF1B282E)
                            : const Color(0xFF0A062F),
                      ),
                    ],
                  ),
                )),
            body: PageView(
                controller: pageController,
                scrollDirection: Axis.vertical,
                onPageChanged: (index) {
                  print("page$index");

                  Future.delayed(const Duration(milliseconds: 1000), () {
                    setState(() {
                      isLocked = false;
                    });
                  });
                },
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                      color: isLocked
                          ? const Color(0xFF1B282E)
                          : const Color(0xFF0A062F),
                      child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(children: [
                            Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomAnimationBuilder<double>(
                                            tween: Tween<double>(
                                                begin: 0.0, end: 1.0),
                                            duration:
                                                const Duration(seconds: 1),
                                            builder: (context, value, child) {
                                              return Transform.scale(
                                                  scale: value,
                                                  child: const SizedBox(
                                                      height: 80,
                                                      width: 80,
                                                      child: RiveAnimation.network(
                                                          "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/kody.riv",
                                                          fit: BoxFit.cover,
                                                          animations: [
                                                            "idle"
                                                          ])));
                                            }),
                                        Expanded(
                                            child: Column(children: [
                                          CustomAnimationBuilder<double>(
                                              tween: Tween<double>(
                                                  begin: 0.0, end: 1.0),
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              builder: (context, value, child) {
                                                return Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            bottom: 10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Transform.scale(
                                                        scale: value,
                                                        child: const Text.rich(
                                                            TextSpan(
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFFC371FE),
                                                                  fontSize: 24,
                                                                  fontFamily:
                                                                      'Eina',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                text: '@',
                                                                children: <InlineSpan>[
                                                              TextSpan(
                                                                  text:
                                                                      'corgis',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        21,
                                                                    fontFamily:
                                                                        'Eina',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                              TextSpan(
                                                                  text: '.',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        21,
                                                                    fontFamily:
                                                                        'Eina',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                              TextSpan(
                                                                  text: 'ai',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFFFEBF4C),
                                                                    fontSize:
                                                                        21,
                                                                    fontFamily:
                                                                        'Eina',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                            ]))));
                                              }),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF0E0657),
                                                border: Border.all(
                                                  color: Colors
                                                      .white, //const Color(0xFF5046E4),
                                                  width: 4,
                                                ),
                                                //color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                        child: AnimatedTextKit(
                                                      onFinished: () {
                                                        setState(() {
                                                          panelIndex = 1;
                                                        });
                                                      },
                                                      repeatForever: false,
                                                      totalRepeatCount: 1,
                                                      animatedTexts: [
                                                        TyperAnimatedTextCustom([
                                                          const TextSpan(
                                                            text:
                                                                '👋 Hello World! 🌌 Welcome to ',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  'Eina',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const TextSpan(
                                                            text: '@',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFFC371FE),
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  'Eina',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const TextSpan(
                                                            text: 'corgis.',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  'Eina',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const TextSpan(
                                                            text: 'ai ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFFFEBF4C),
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  'Eina',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const TextSpan(
                                                              text:
                                                                  'your best friend 🐶 for learning programming languages.',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 24,
                                                                fontFamily:
                                                                    'Eina',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )),
                                                        ],
                                                            speed:
                                                                const Duration(
                                                                    milliseconds:
                                                                        50)),
                                                      ],
                                                    )),
                                                  ])),

                                          // panelIndex >= 2
                                          //     ? Container(
                                          //         margin: const EdgeInsets.only(
                                          //             top: 20, left: 10),
                                          //         padding:
                                          //             const EdgeInsets.all(10),
                                          //         decoration: BoxDecoration(
                                          //           color:
                                          //               const Color(0xFF0E0657),
                                          //           border: Border.all(
                                          //             color: Colors
                                          //                 .white, //const Color(0xFF5046E4),
                                          //             width: 4,
                                          //           ),
                                          //           //color: Colors.white,
                                          //           borderRadius:
                                          //               BorderRadius.circular(
                                          //                   10),
                                          //         ),
                                          //         child: Row(
                                          //             mainAxisAlignment:
                                          //                 MainAxisAlignment
                                          //                     .center,
                                          //             children: [
                                          //               Expanded(
                                          //                   child:
                                          //                       AnimatedTextKit(
                                          //                 onFinished: () {
                                          //                   setState(() {
                                          //                     print(scrollController
                                          //                         .position
                                          //                         .maxScrollExtent);
                                          //                     scrollController
                                          //                         .animateTo(
                                          //                       scrollController
                                          //                           .position
                                          //                           .maxScrollExtent,
                                          //                       curve: Curves
                                          //                           .easeOut,
                                          //                       duration: const Duration(
                                          //                           milliseconds:
                                          //                               1000),
                                          //                     );
                                          //                   });
                                          //                 },
                                          //                 repeatForever: false,
                                          //                 totalRepeatCount: 1,
                                          //                 animatedTexts: [
                                          //                   TyperAnimatedTextCustom([
                                          //                     const TextSpan(
                                          //                       text:
                                          //                           'Embark on a quest 🚀 with gamified lessons that not only boost your skills 💪 but also prepare you for interviews 🎤, all supported by AI 🤖.',
                                          //                       style:
                                          //                           TextStyle(
                                          //                         color: Colors
                                          //                             .white,
                                          //                         fontSize: 24,
                                          //                         fontFamily:
                                          //                             'Eina',
                                          //                         fontWeight:
                                          //                             FontWeight
                                          //                                 .bold,
                                          //                       ),
                                          //                     ),
                                          //                   ],
                                          //                       speed: const Duration(
                                          //                           milliseconds:
                                          //                               50)),
                                          //                 ],
                                          //               )),
                                          //             ]))
                                          //     : Container(),
                                        ])),
                                      ]),
                                ])),
                          ]))),
                  Container(
                      color: isLocked
                          ? const Color(0xFF1B282E)
                          : const Color(0xFF0A062F),
                      child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(children: [
                            Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomAnimationBuilder<double>(
                                            tween: Tween<double>(
                                                begin: 0.0, end: 1.0),
                                            duration:
                                                const Duration(seconds: 1),
                                            builder: (context, value, child) {
                                              return Transform.scale(
                                                  scale: value,
                                                  child: const SizedBox(
                                                      height: 80,
                                                      width: 80,
                                                      child: RiveAnimation.network(
                                                          "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/kody.riv",
                                                          fit: BoxFit.cover,
                                                          animations: [
                                                            "idle"
                                                          ])));
                                            }),
                                        Expanded(
                                            child: Column(children: [
                                          CustomAnimationBuilder<double>(
                                              tween: Tween<double>(
                                                  begin: 0.0, end: 1.0),
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              builder: (context, value, child) {
                                                return Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            bottom: 10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Transform.scale(
                                                        scale: value,
                                                        child: const Text.rich(
                                                            TextSpan(
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFFC371FE),
                                                                  fontSize: 24,
                                                                  fontFamily:
                                                                      'Eina',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                text: '@',
                                                                children: <InlineSpan>[
                                                              TextSpan(
                                                                  text:
                                                                      'corgis',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        21,
                                                                    fontFamily:
                                                                        'Eina',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                              TextSpan(
                                                                  text: '.',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        21,
                                                                    fontFamily:
                                                                        'Eina',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                              TextSpan(
                                                                  text: 'ai',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFFFEBF4C),
                                                                    fontSize:
                                                                        21,
                                                                    fontFamily:
                                                                        'Eina',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                            ]))));
                                              }),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 20, left: 10),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF0E0657),
                                                border: Border.all(
                                                  color: Colors
                                                      .white, //const Color(0xFF5046E4),
                                                  width: 4,
                                                ),
                                                //color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                        child: AnimatedTextKit(
                                                      onFinished: () {
                                                        setState(() {
                                                          setState(() {
                                                            panelIndex = 1;
                                                          });
                                                          // print(scrollController
                                                          //     .position
                                                          //     .maxScrollExtent);
                                                          // scrollController
                                                          //     .animateTo(
                                                          //   scrollController
                                                          //       .position
                                                          //       .maxScrollExtent,
                                                          //   curve:
                                                          //       Curves.easeOut,
                                                          //   duration:
                                                          //       const Duration(
                                                          //           milliseconds:
                                                          //               1000),
                                                          // );
                                                        });
                                                      },
                                                      repeatForever: false,
                                                      totalRepeatCount: 1,
                                                      animatedTexts: [
                                                        TyperAnimatedTextCustom([
                                                          const TextSpan(
                                                            text:
                                                                'Embark on a quest 🚀 with gamified lessons that not only boost your skills 💪 but also prepare you for interviews 🎤, all supported by AI 🤖.',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  'Eina',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                            speed:
                                                                const Duration(
                                                                    milliseconds:
                                                                        25)),
                                                      ],
                                                    )),
                                                  ])),
                                          panelIndex >= 1
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF0E0657),
                                                    border: Border.all(
                                                      color: Colors
                                                          .white, //const Color(0xFF5046E4),
                                                      width: 4,
                                                    ),
                                                    //color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                            child:
                                                                AnimatedTextKit(
                                                          onFinished: () {
                                                            // setState(() {
                                                            //   panelIndex = 1;
                                                            // });
                                                          },
                                                          repeatForever: false,
                                                          totalRepeatCount: 1,
                                                          animatedTexts: [
                                                            TyperAnimatedTextCustom([
                                                              const TextSpan(
                                                                text:
                                                                    'Start from zero and progress in a fun, engaging way!',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 24,
                                                                  fontFamily:
                                                                      'Eina',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              )
                                                            ],
                                                                speed: const Duration(
                                                                    milliseconds:
                                                                        25)),
                                                          ],
                                                        )),
                                                      ]))
                                              : Container(),
                                        ])),
                                      ]),
                                ])),
                          ]))),
                  Container(
                      color: isLocked
                          ? const Color(0xFF1B282E)
                          : const Color(0xFF0A062F),
                      child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(children: [
                            Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomAnimationBuilder<double>(
                                            tween: Tween<double>(
                                                begin: 0.0, end: 1.0),
                                            duration:
                                                const Duration(seconds: 1),
                                            builder: (context, value, child) {
                                              return Transform.scale(
                                                  scale: value,
                                                  child: const SizedBox(
                                                      height: 80,
                                                      width: 80,
                                                      child: RiveAnimation.network(
                                                          "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/kody.riv",
                                                          fit: BoxFit.cover,
                                                          animations: [
                                                            "idle"
                                                          ])));
                                            }),
                                        Expanded(
                                            child: Column(children: [
                                          CustomAnimationBuilder<double>(
                                              tween: Tween<double>(
                                                  begin: 0.0, end: 1.0),
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              builder: (context, value, child) {
                                                return Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            bottom: 10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Transform.scale(
                                                        scale: value,
                                                        child: const Text.rich(
                                                            TextSpan(
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFFC371FE),
                                                                  fontSize: 24,
                                                                  fontFamily:
                                                                      'Eina',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                text: '@',
                                                                children: <InlineSpan>[
                                                              TextSpan(
                                                                  text:
                                                                      'corgis',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        21,
                                                                    fontFamily:
                                                                        'Eina',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                              TextSpan(
                                                                  text: '.',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        21,
                                                                    fontFamily:
                                                                        'Eina',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                              TextSpan(
                                                                  text: 'ai',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFFFEBF4C),
                                                                    fontSize:
                                                                        21,
                                                                    fontFamily:
                                                                        'Eina',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                            ]))));
                                              }),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF0E0657),
                                                border: Border.all(
                                                  color: Colors
                                                      .white, //const Color(0xFF5046E4),
                                                  width: 4,
                                                ),
                                                //color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                        child: AnimatedTextKit(
                                                      onFinished: () {
                                                        setState(() {
                                                          panelIndex = 1;
                                                        });
                                                      },
                                                      repeatForever: false,
                                                      totalRepeatCount: 1,
                                                      animatedTexts: [
                                                        TyperAnimatedTextCustom([
                                                          const TextSpan(
                                                            text:
                                                                'Signing up is just a click away with your email or through Google or Apple.',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  'Eina',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        ],
                                                            speed:
                                                                const Duration(
                                                                    milliseconds:
                                                                        25)),
                                                      ],
                                                    )),
                                                  ])),
                                          panelIndex >= 1
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 20, left: 10),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF0E0657),
                                                    border: Border.all(
                                                      color: Colors
                                                          .white, //const Color(0xFF5046E4),
                                                      width: 4,
                                                    ),
                                                    //color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                            child:
                                                                AnimatedTextKit(
                                                          onFinished: () {
                                                            // setState(() {
                                                            //   panelIndex = 1;
                                                            // });
                                                          },
                                                          repeatForever: false,
                                                          totalRepeatCount: 1,
                                                          animatedTexts: [
                                                            TyperAnimatedTextCustom([
                                                              const TextSpan(
                                                                text:
                                                                    'We prioritize your privacy, ensuring a spam-free adventure.',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 24,
                                                                  fontFamily:
                                                                      'Eina',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              )
                                                            ],
                                                                speed: const Duration(
                                                                    milliseconds:
                                                                        25)),
                                                          ],
                                                        )),
                                                      ]))
                                              : Container(),
                                        ])),
                                      ]),
                                  GestureDetector(
                                      onTap: () async {
                                        showModalBottomSheet<void>(
                                          isScrollControlled: true,
                                          backgroundColor:
                                              const Color(0xFF0E0657),
                                          context: context,
                                          builder: (
                                            BuildContext context,
                                          ) {
                                            return StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter setModalState) {
                                              return SafeArea(
                                                  child: SizedBox(
                                                      child: Center(
                                                          child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 50,
                                                                      left: 10,
                                                                      right: 10,
                                                                      bottom:
                                                                          10),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: !isEmailValid
                                                                          ? const Color(
                                                                              0xFF1B282E)
                                                                          : const Color(
                                                                              0xFF0E0657),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: !isEmailValid
                                                                            ? const Color(0xFF131F24)
                                                                            : Colors.transparent,
                                                                        width:
                                                                            4,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)
                                                                      // color: !isEmailValid
                                                                      //     ? Color(
                                                                      //         0xFF1B282E)
                                                                      //     : const Color(
                                                                      //         0xFF0E0657),
                                                                      ),
                                                              child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            70,
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child:
                                                                              SizedBox(
                                                                            height:
                                                                                70,
                                                                            width:
                                                                                70,
                                                                            child: IconButton(
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                icon: const Icon(Icons.close, color: Colors.white),
                                                                                iconSize: 50), // Specify the width of the green container
                                                                          ),
                                                                        )),
                                                                    Container(
                                                                        height:
                                                                            300,
                                                                        color: !isEmailValid
                                                                            ? const Color(
                                                                                0xFF1B282E)
                                                                            : Colors
                                                                                .transparent,
                                                                        child: const RiveAnimation
                                                                            .network(
                                                                            'https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/corgi_mail.riv',
                                                                            fit: BoxFit.cover,
                                                                            animations: [
                                                                              'idle'
                                                                            ])),
                                                                    Container(
                                                                        height:
                                                                            10),
                                                                    Container(
                                                                        margin: const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                10),
                                                                        child: CustomAnimationBuilder<
                                                                                double>(
                                                                            tween:
                                                                                Tween<double>(begin: 0.0, end: 1.0),
                                                                            duration: const Duration(milliseconds: 500),
                                                                            builder: (context, value, child) {
                                                                              return Transform.scale(
                                                                                  scale: value,
                                                                                  child: Form(
                                                                                      key: formKey,
                                                                                      child: Column(children: [
                                                                                        SizedBox(
                                                                                            height: 70,
                                                                                            width: 500,
                                                                                            child: Column(children: [
                                                                                              TextFormField(
                                                                                                  cursorWidth: 4,
                                                                                                  cursorColor: const Color(0xFF5F5DEF),
                                                                                                  style: const TextStyle(
                                                                                                    color: Colors.white,
                                                                                                    fontSize: 20,
                                                                                                    fontFamily: 'Eina',
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                  ),
                                                                                                  keyboardType: TextInputType.emailAddress,
                                                                                                  autofillHints: const [AutofillHints.email],
                                                                                                  onChanged: (value) {
                                                                                                    if (value.isNotEmpty) {
                                                                                                      if (EmailValidator.validate(value)) {
                                                                                                        setModalState(() {
                                                                                                          isEmailValid = true;
                                                                                                        });
                                                                                                        setState(() {
                                                                                                          isEmailValid = true;
                                                                                                        });
                                                                                                      } else {
                                                                                                        setModalState(() {
                                                                                                          isEmailValid = false;
                                                                                                        });
                                                                                                        setState(() {
                                                                                                          isEmailValid = false;
                                                                                                        });
                                                                                                      }
                                                                                                    }
                                                                                                  },
                                                                                                  validator: (value) {
                                                                                                    if (value == null || value.isEmpty || !EmailValidator.validate(emailController.text)) {
                                                                                                      return 'Please enter a valid email address';
                                                                                                    }
                                                                                                    return null;
                                                                                                  },
                                                                                                  decoration: InputDecoration(
                                                                                                      focusedBorder: OutlineInputBorder(
                                                                                                        borderRadius: BorderRadius.circular(16.0),
                                                                                                        borderSide: const BorderSide(
                                                                                                          color: Color(0xFF5F5DEF),
                                                                                                          width: 4.0,
                                                                                                        ),
                                                                                                      ),
                                                                                                      enabledBorder: OutlineInputBorder(
                                                                                                        borderRadius: BorderRadius.circular(16.0),
                                                                                                        borderSide: const BorderSide(
                                                                                                          color: Color(0xFF5F5DEF),
                                                                                                          width: 4.0,
                                                                                                        ),
                                                                                                      ),
                                                                                                      border: OutlineInputBorder(
                                                                                                        borderRadius: BorderRadius.circular(16),
                                                                                                      ),
                                                                                                      hintStyle: const TextStyle(fontFamily: 'Eina', fontSize: 18, color: Colors.white),
                                                                                                      prefixIcon: const Icon(Icons.email, color: Colors.white),
                                                                                                      hintText: 'Enter an email address'),
                                                                                                  controller: emailController)
                                                                                            ])),
                                                                                        Container(
                                                                                            margin: const EdgeInsets.only(top: 10, bottom: 20),
                                                                                            child: GestureDetector(
                                                                                                onTap: () {
                                                                                                  if (formKey.currentState!.validate()) {
                                                                                                    login();
                                                                                                    Navigator.pop(context);
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
                                                                                                child: CustomAnimationBuilder<double>(
                                                                                                    // control:
                                                                                                    //     control, // bind variable with control instruction
                                                                                                    tween: Tween<double>(begin: 0.0, end: 1.0),
                                                                                                    duration: const Duration(milliseconds: 500),
                                                                                                    builder: (context, value, child) {
                                                                                                      return Transform.scale(
                                                                                                          scale: value,
                                                                                                          child: Column(children: [
                                                                                                            Container(
                                                                                                                height: 50,
                                                                                                                width: 500,
                                                                                                                decoration: BoxDecoration(
                                                                                                                    color: !isEmailValid ? const Color(0xFF202F36) : Color(0xFFA2FF66),
                                                                                                                    borderRadius: const BorderRadius.only(
                                                                                                                      topRight: Radius.circular(10),
                                                                                                                      topLeft: Radius.circular(10),
                                                                                                                    )),
                                                                                                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                                  Container(
                                                                                                                    margin: const EdgeInsets.only(left: 5),
                                                                                                                    child: isLoading
                                                                                                                        ? const CircularProgressIndicator(
                                                                                                                            strokeWidth: 4,
                                                                                                                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1a1e4c)),
                                                                                                                          )
                                                                                                                        : Row(children: [
                                                                                                                            !isEmailValid
                                                                                                                                ? Container(
                                                                                                                                    margin: const EdgeInsets.only(right: 10),
                                                                                                                                    height: 30,
                                                                                                                                    width: 30,
                                                                                                                                    child: const RiveAnimation.asset(
                                                                                                                                      'assets/images/icons/lock.riv',
                                                                                                                                      animations: ['idle'],
                                                                                                                                      fit: BoxFit.contain,
                                                                                                                                    ))
                                                                                                                                : Container(),
                                                                                                                            Text(
                                                                                                                              "subscribe",
                                                                                                                              style: TextStyle(
                                                                                                                                color: !isEmailValid ? const Color(0xFF49C1F9) : Color(0xFF1a1e4c),
                                                                                                                                fontSize: 21,
                                                                                                                                fontFamily: 'Eina',
                                                                                                                                fontWeight: FontWeight.bold,
                                                                                                                              ),
                                                                                                                            )
                                                                                                                          ]),
                                                                                                                  )
                                                                                                                ])),
                                                                                                            Container(
                                                                                                              height: 15,
                                                                                                              width: 500,
                                                                                                              decoration: BoxDecoration(
                                                                                                                  border: Border.all(
                                                                                                                    color: !isEmailValid ? const Color(0xFF384650) : const Color(0xFF69EC15),
                                                                                                                    width: 3,
                                                                                                                  ),
                                                                                                                  borderRadius: const BorderRadius.only(
                                                                                                                    bottomRight: Radius.circular(10),
                                                                                                                    bottomLeft: Radius.circular(10),
                                                                                                                  ),
                                                                                                                  color: !isEmailValid ? const Color(0xFF384650) : const Color(0xFF69EC15)),
                                                                                                            ),
                                                                                                          ]));
                                                                                                    }))),
                                                                                      ])));
                                                                            })),
                                                                  ])))));
                                            });
                                          },
                                        );
                                      },
                                      child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          //color: Colors.red,
                                          height: 120,
                                          child: Row(children: [
                                            Expanded(
                                                child: Container(
                                                    height: 120,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF0A062F),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFF23197D),
                                                        // Color(
                                                        // 0xFF5F5DEF), //const Color(0xFF5046E4),
                                                        width: 4,
                                                      ),
                                                      //color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                              height: 50,
                                                              width: 50,
                                                              child: Icon(
                                                                  size: 45.0,
                                                                  Icons.email,
                                                                  color: Colors
                                                                      .white)),
                                                          Text("email",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 21,
                                                                fontFamily:
                                                                    'Eina',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )),
                                                        ]))),
                                            Container(width: 10),
                                            Expanded(
                                                child: GestureDetector(
                                                    onTap: () async {
                                                      setState(() {
                                                        selectGoogleSignIn =
                                                            true;
                                                      });
                                                      print(selectGoogleSignIn);
                                                      try {
                                                        await _googleSignIn();
                                                        setState(() {
                                                          selectGoogleSignIn =
                                                              false;
                                                        });
                                                      } catch (e) {
                                                        setState(() {
                                                          selectGoogleSignIn =
                                                              false;
                                                        });
                                                        print(e);
                                                      }
                                                    },
                                                    child: Container(
                                                        height: 120,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: selectGoogleSignIn
                                                              ? const Color(
                                                                      0xFFBDFF9C)
                                                                  .withOpacity(
                                                                      0.85)
                                                              : const Color(
                                                                  0xFF0A062F),
                                                          border: Border.all(
                                                            color: selectGoogleSignIn ==
                                                                    true
                                                                ? const Color(
                                                                    0xFF42FF00)
                                                                : const Color(
                                                                    0xFF23197D),
                                                            // Color(
                                                            // 0xFF5F5DEF), //const Color(0xFF5046E4),
                                                            width: 4,
                                                          ),
                                                          //color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                  height: 50,
                                                                  width: 50,
                                                                  child: selectGoogleSignIn
                                                                      ? const CircularProgressIndicator(
                                                                          strokeWidth:
                                                                              4,
                                                                          valueColor:
                                                                              AlwaysStoppedAnimation<Color>(Color(0xFF1a1e4c)),
                                                                        )
                                                                      : const RiveAnimation.asset(
                                                                          'assets/images/icons/google.riv',
                                                                          animations: [
                                                                            'idle'
                                                                          ],
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        )),
                                                              const Text(
                                                                  "google",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        21,
                                                                    fontFamily:
                                                                        'Eina',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                            ])))),
                                            Container(width: 10),
                                            Expanded(
                                                child: Container(
                                                    height: 120,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF0A062F),
                                                      border: Border.all(
                                                        color: const Color(
                                                            0xFF23197D),
                                                        // Color(
                                                        // 0xFF5F5DEF), //const Color(0xFF5046E4),
                                                        width: 4,
                                                      ),
                                                      //color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                              height: 50,
                                                              width: 50,
                                                              child:
                                                                  RiveAnimation
                                                                      .asset(
                                                                'assets/images/icons/apple_light.riv',
                                                                animations: [
                                                                  'idle'
                                                                ],
                                                                fit: BoxFit
                                                                    .contain,
                                                              )),
                                                          Text("apple",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 21,
                                                                fontFamily:
                                                                    'Eina',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )),
                                                        ]))),
                                          ])))
                                ])),
                          ]))),
                  Container(
                      color: isLocked
                          ? const Color(0xFF1B282E)
                          : const Color(0xFF0A062F),
                      child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(children: [
                            Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomAnimationBuilder<double>(
                                            tween: Tween<double>(
                                                begin: 0.0, end: 1.0),
                                            duration:
                                                const Duration(seconds: 1),
                                            builder: (context, value, child) {
                                              return Transform.scale(
                                                  scale: value,
                                                  child: const SizedBox(
                                                      height: 80,
                                                      width: 80,
                                                      child: RiveAnimation.network(
                                                          "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/kody.riv",
                                                          fit: BoxFit.cover,
                                                          animations: [
                                                            "idle"
                                                          ])));
                                            }),
                                        Expanded(
                                            child: Column(children: [
                                          CustomAnimationBuilder<double>(
                                              tween: Tween<double>(
                                                  begin: 0.0, end: 1.0),
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              builder: (context, value, child) {
                                                return Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            bottom: 10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Transform.scale(
                                                        scale: value,
                                                        child: const Text.rich(
                                                            TextSpan(
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFFC371FE),
                                                                  fontSize: 24,
                                                                  fontFamily:
                                                                      'Eina',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                text: '@',
                                                                children: <InlineSpan>[
                                                              TextSpan(
                                                                  text:
                                                                      'corgis',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        21,
                                                                    fontFamily:
                                                                        'Eina',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                              TextSpan(
                                                                  text: '.',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        21,
                                                                    fontFamily:
                                                                        'Eina',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                              TextSpan(
                                                                  text: 'ai',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFFFEBF4C),
                                                                    fontSize:
                                                                        21,
                                                                    fontFamily:
                                                                        'Eina',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                            ]))));
                                              }),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF0E0657),
                                                border: Border.all(
                                                  color: Colors
                                                      .white, //const Color(0xFF5046E4),
                                                  width: 4,
                                                ),
                                                //color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                        child: AnimatedTextKit(
                                                      onFinished: () {
                                                        setState(() {
                                                          panelIndex = 1;
                                                        });
                                                      },
                                                      repeatForever: false,
                                                      totalRepeatCount: 1,
                                                      animatedTexts: [
                                                        TyperAnimatedTextCustom([
                                                          TextSpan(
                                                            text:
                                                                'You\'re all set! Begin as @${username}, but you\'ll soon get to choose your own coding hero identity.',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  'Eina',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        ],
                                                            speed:
                                                                const Duration(
                                                                    milliseconds:
                                                                        25)),
                                                      ],
                                                    )),
                                                  ])),
                                        ])),
                                      ]),
                                ])),
                          ]))),
                  Container(color: Colors.red, child: SingleChildScrollView())
                ]),
            bottomNavigationBar: page == 2
                ? Container(
                    color: isLocked
                        ? const Color(0xFF1B282E)
                        : const Color(0xFF0A062F),
                    padding: const EdgeInsets.only(
                        top: 20, right: 20, left: 20, bottom: 20),
                    height: 100)
                : Container(
                    padding: const EdgeInsets.only(
                        top: 20, right: 20, left: 20, bottom: 20),
                    height: 125,
                    color: isLocked
                        ? const Color(0xFF1B282E)
                        : const Color(0xFF0A062F),
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    if (!isLocked) {
                                      setState(() {
                                        page += 1;
                                        panelIndex = 0;
                                        isLocked = true;
                                      });
                                      pageController.animateToPage(page,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut);

                                      //print(page);
                                    }
                                  },
                                  child: CustomAnimationBuilder<double>(
                                      tween:
                                          Tween<double>(begin: 0.0, end: 1.0),
                                      duration:
                                          const Duration(milliseconds: 500),
                                      builder: (context, value, child) {
                                        return Transform.scale(
                                            scale: value,
                                            child: Column(children: [
                                              Container(
                                                  height: 50,
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width <
                                                          500
                                                      ? 400
                                                      : 500.0,
                                                  decoration: BoxDecoration(
                                                      color: isLocked
                                                          ? const Color(
                                                              0xFF202F36)
                                                          : const Color(
                                                              0xFFA2FF66),
                                                      borderRadius:
                                                          const BorderRadius
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
                                                        Transform(
                                                          transform:
                                                              Matrix4.skewX(
                                                                  -0.5),
                                                          origin: const Offset(
                                                              0.0, 0.0),
                                                          child: Container(
                                                            height: 100.0,
                                                            width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width <
                                                                    500
                                                                ? 70
                                                                : 150.0,
                                                            color: isLocked
                                                                ? const Color(
                                                                    0xFF202F36)
                                                                : const Color(
                                                                    0xFFB9FF8C),
                                                          ),
                                                        ),
                                                        Center(
                                                            child:
                                                                Row(children: [
                                                          isLocked
                                                              ? Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10),
                                                                  height: 30,
                                                                  width: 30,
                                                                  child:
                                                                      const RiveAnimation
                                                                          .asset(
                                                                    'assets/images/icons/lock.riv',
                                                                    animations: [
                                                                      'idle'
                                                                    ],
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ))
                                                              : Container(),
                                                          Text(
                                                            "continue",
                                                            style: TextStyle(
                                                              color: isLocked
                                                                  ? const Color(
                                                                      0xFF49C1F9)
                                                                  : const Color(
                                                                      0xFF1a1e4c),
                                                              fontSize: 21,
                                                              fontFamily:
                                                                  'Eina',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        ])),
                                                        Transform(
                                                          transform:
                                                              Matrix4.skewX(
                                                                  -0.5),
                                                          origin: const Offset(
                                                              0.0, 50.0),
                                                          child: Container(
                                                            height: 100.0,
                                                            width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width <
                                                                    500
                                                                ? 70
                                                                : 150.0,
                                                            color: isLocked
                                                                ? const Color(
                                                                    0xFF202F36)
                                                                : const Color(
                                                                    0xFFB9FF8C),
                                                          ),
                                                        ),
                                                      ])),
                                              Container(
                                                height: 15,
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        500
                                                    ? 400
                                                    : 500,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: isLocked
                                                        ? const Color(
                                                            0xFF384650)
                                                        : const Color(
                                                            0xFF69EC15),
                                                    width: 3,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                  color: isLocked
                                                      ? const Color(0xFF384650)
                                                      : const Color(0xFF69EC15),
                                                ),
                                              ),
                                            ]));
                                      }))),
                        ])))));
  }
}

// Hello World! 🌌 Welcome to corgis.ai, your best friend in coding. Embark on a quest with gamified lessons that not only boost your skills but also prepare you for interviews, all supported by AI. 
// Start from zero and progress in a fun, engaging way!

// Signing up is just a click away with your email or through Google or Apple. We prioritize your privacy, ensuring a spam-free adventure.

// You're all set! Begin as @[your_email], but soon, you'll craft your unique coding identity.

// 🔔 A special surprise awaits in your inbox to kickstart your journey. Explore a world where coding basics meet the thrill of solving interview puzzles, guided by our AI friends.

// Ready for an adventure that sharpens your coding skills and readies you for real-world challenges? 
// Let's embark on this journey together!
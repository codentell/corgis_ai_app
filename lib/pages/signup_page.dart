import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:corgis_ai_app/components/TyperAnimatedTextCustom.dart';
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
  late String username = "";
  late bool isAuthenticating;
  ScrollController scrollController = new ScrollController();
  final PageController pageController = PageController();

  @override
  void initState() {
    setState(() {
      page = 0;
      panelIndex = 0;
      isAuthenticating = false;
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
          var email = supabase.auth.currentUser?.email ?? "@[email]";
          setState(() {
            isAuthenticating = true;
            username = email.split("@")[0];
          });
        }
        if (isAuthenticating) {
          pageController.animateToPage(3,
              duration: const Duration(milliseconds: 1000),
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

  Future<AuthResponse> googleSignIn() async {
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
                        color: const Color(0xFF0A062F),
                      ),
                    ],
                  ),
                )),
            body: PageView(
                controller: pageController,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                      color: const Color(0xFF0A062F),
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
                      color: const Color(0xFF0A062F),
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
                      color: const Color(0xFF0A062F),
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
                                        // showModalBottomSheet<void>(
                                        //   context: context,
                                        //   builder: (BuildContext context) {
                                        //     return SizedBox(
                                        //         height: 200,
                                        //         child: Center(
                                        //           child: Column(
                                        //             mainAxisAlignment:
                                        //                 MainAxisAlignment
                                        //                     .center,
                                        //             mainAxisSize:
                                        //                 MainAxisSize.min,
                                        //             children: <Widget>[
                                        //               const Text(
                                        //                   'Modal BottomSheet'),
                                        //               ElevatedButton(
                                        //                 child: const Text(
                                        //                     'Close BottomSheet'),
                                        //                 onPressed: () =>
                                        //                     Navigator.pop(
                                        //                         context),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ));
                                        //   },
                                        // );
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
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
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
                                                    onTap: () {
                                                      googleSignIn();
                                                    },
                                                    child: Container(
                                                        height: 120,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFF0A062F),
                                                          border: Border.all(
                                                            color: Color(
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
                                                                  child:
                                                                      RiveAnimation
                                                                          .asset(
                                                                    'assets/images/icons/google.riv',
                                                                    animations: const [
                                                                      'idle'
                                                                    ],
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  )),
                                                              Text("google",
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
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                              height: 50,
                                                              width: 50,
                                                              child:
                                                                  RiveAnimation
                                                                      .asset(
                                                                'assets/images/icons/apple_light.riv',
                                                                animations: const [
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
                      color: const Color(0xFF0A062F),
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
                                        ])),
                                      ]),
                                ])),
                          ]))),
                ]),
            bottomNavigationBar: Container(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 20),
                height: 125,
                color: const Color(0xFF0A062F),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Expanded(
                          child: GestureDetector(
                              onTap: () {
                                pageController.animateToPage(page + 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                                setState(() {
                                  page += 1;
                                  panelIndex = 0;
                                });
                                print(page);
                              },
                              child: CustomAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0.0, end: 1.0),
                                  duration: const Duration(milliseconds: 500),
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
                                                  color: Color(0xFFA2FF66),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10),
                                                  )),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Transform(
                                                      transform:
                                                          Matrix4.skewX(-0.5),
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
                                                        color: const Color(
                                                            0xFFB9FF8C),
                                                      ),
                                                    ),
                                                    Center(
                                                        child: Text(
                                                      "continue",
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0xFF1a1e4c),
                                                        fontSize: 21,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                                    Transform(
                                                      transform:
                                                          Matrix4.skewX(-0.5),
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
                                                        color: const Color(
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
                                                color: const Color(0xFF69EC15),
                                                width: 3,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              color: const Color(0xFF69EC15),
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
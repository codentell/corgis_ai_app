import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:rive/rive.dart';
import 'package:corgis_ai_app/components/TyperAnimatedTextCustom.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  late bool useLocalAsset = false;
  launchURL(url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _checkResourceAvailability() async {
    try {
      final response = await http.head(Uri.parse(
          "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/banner.riv"));
      if (response.statusCode == 200) {
        // Resource available, do nothing special
      } else {
        // Resource not available or error, use local asset
        setState(() {
          useLocalAsset = true;
        });
      }
    } catch (e) {
      // Network error or other exception, use local asset
      setState(() {
        useLocalAsset = true;
      });
    }
  }

  void initState() {
    super.initState();
  }

  // void onInit(Artboard artboard) async {
  //   print('Rive animation initialized');
  //   // _controller = StateMachineController.fromArtboard(artboard, 'panel')!;
  //   // artboard.addController(_controller);

  //   // _controller.addEventListener(onRiveEvent);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFF0A062F),
            body: Container(
                color: const Color(0xFF0A062F),
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 350,
                            width: 350,
                            child: useLocalAsset
                                ? RiveAnimation.network(
                                    "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/banner.riv",
                                    fit: BoxFit.cover,
                                    stateMachines: ["game"],
                                    //onInit: onInit,
                                  )
                                : RiveAnimation.asset(
                                    "assets/images/graphics/banner.riv",
                                    fit: BoxFit.cover,
                                    stateMachines: ["game"],
                                    //onInit: onInit,
                                  )),
                        Container(
                            child: const Text.rich(TextSpan(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: 'Eina',
                                  fontWeight: FontWeight.bold,
                                ),
                                text: 'corgis',
                                children: <InlineSpan>[
                              TextSpan(
                                text: '.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: 'Eina',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'ai',
                                style: TextStyle(
                                  color: Color(0xFFFEBF4C),
                                  fontSize: 30,
                                  fontFamily: 'Eina',
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ]))),
                        SizedBox(
                            width: 450,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Learn ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Eina',
                                        fontWeight: FontWeight.bold,
                                      )),
                                  AnimatedTextKit(
                                      repeatForever: true,
                                      isRepeatingAnimation: true,
                                      animatedTexts: [
                                        TyperAnimatedTextCustom([
                                          const TextSpan(
                                            text: 'llm ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                            speed: const Duration(
                                                milliseconds: 100)),
                                        TyperAnimatedTextCustom([
                                          const TextSpan(
                                            text: 'prompts',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                            speed: const Duration(
                                                milliseconds: 100)),
                                        TyperAnimatedTextCustom([
                                          const TextSpan(
                                            text: 'py',
                                            style: TextStyle(
                                              color: Color(0xFF26A3FF),
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: 'thon',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                            speed: const Duration(
                                                milliseconds: 100)),
                                        TyperAnimatedTextCustom([
                                          const TextSpan(
                                            text: 'r',
                                            style: TextStyle(
                                              color: Color(0xFFF49600),
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: 'u',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: 's',
                                            style: TextStyle(
                                              color: Color(0xFFF49600),
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: 't',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                            speed: const Duration(
                                                milliseconds: 100)),
                                        TyperAnimatedTextCustom([
                                          const TextSpan(
                                            text: 'p',
                                            style: TextStyle(
                                              color: Color(0xFFFF0078),
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: 'an',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                              text: 'd',
                                              style: TextStyle(
                                                color: Color(0xFFFF0078),
                                                fontSize: 20,
                                                fontFamily: 'Eina',
                                                fontWeight: FontWeight.bold,
                                              )),
                                          const TextSpan(
                                              text: 'as',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Eina',
                                                fontWeight: FontWeight.bold,
                                              ))
                                        ],
                                            speed: const Duration(
                                                milliseconds: 100)),
                                        TyperAnimatedTextCustom([
                                          const TextSpan(
                                            text: 'j',
                                            style: TextStyle(
                                              color: Color(0xFFf1e05a),
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: 'ava',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                              text: 's',
                                              style: TextStyle(
                                                color: Color(0xFFf1e05a),
                                                fontSize: 20,
                                                fontFamily: 'Eina',
                                                fontWeight: FontWeight.bold,
                                              )),
                                          const TextSpan(
                                              text: 'cript',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Eina',
                                                fontWeight: FontWeight.bold,
                                              ))
                                        ],
                                            speed: const Duration(
                                                milliseconds: 100)),
                                        TyperAnimatedTextCustom([
                                          const TextSpan(
                                            text: 'mat',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: 'pl',
                                            style: TextStyle(
                                              color: Color(0xFFD0FF83),
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                              text: 'o',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Eina',
                                                fontWeight: FontWeight.bold,
                                              )),
                                          const TextSpan(
                                              text: 't',
                                              style: TextStyle(
                                                color: Color(0xFFD0FF83),
                                                fontSize: 20,
                                                fontFamily: 'Eina',
                                                fontWeight: FontWeight.bold,
                                              )),
                                          const TextSpan(
                                              text: 'lib',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Eina',
                                                fontWeight: FontWeight.bold,
                                              ))
                                        ],
                                            speed: const Duration(
                                                milliseconds: 100)),
                                        TyperAnimatedText('html',
                                            textStyle: const TextStyle(
                                              color: Colors.orange,
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                            speed: const Duration(
                                                milliseconds: 100)),
                                        TyperAnimatedText('git',
                                            textStyle: const TextStyle(
                                              color: Color(0xFFFF7E00),
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                            speed: const Duration(
                                                milliseconds: 100)),
                                        TyperAnimatedText('typescript',
                                            textStyle: const TextStyle(
                                              color: Color(0xFF0278CC),
                                              fontSize: 20,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                            speed: const Duration(
                                                milliseconds: 100)),
                                      ]),
                                  const Text(" with AI-powered",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Eina',
                                        fontWeight: FontWeight.bold,
                                      ))
                                ])),
                        const SizedBox(
                            width: 450,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(" friends and gamified lessons!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Eina',
                                        fontWeight: FontWeight.bold,
                                      ))
                                ]))
                      ]),
                )),
            bottomNavigationBar: Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, right: 20, left: 20),
                height: 270,
                color: const Color(0xFF0A062F),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/welcome/0');
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
                                              decoration: const BoxDecoration(
                                                  color: Color(0xFFA2FF66),
                                                  borderRadius:
                                                      BorderRadius.only(
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
                                                    const Center(
                                                        child: Text(
                                                      "get started",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF1a1e4c),
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
                      Expanded(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/login');
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
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      500
                                                  ? 400
                                                  : 500,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xFFcc86ff),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10),
                                                  )),
                                              child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      "I already have an account",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF1a1e4c),
                                                        fontSize: 21,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
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
                                                color: const Color(0xFFC371FE),
                                                width: 3,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              color: const Color(0xFFC371FE),
                                            ),
                                          ),
                                        ]));
                                  }))),
                      Expanded(
                          child: Center(
                              child: Text.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(children: [
                                    const TextSpan(
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Eina',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        text:
                                            "By continuing, you agree to corgis."),
                                    const TextSpan(
                                        style: TextStyle(
                                          color: Color(0xFFFEBF4C),
                                          fontSize: 14,
                                          fontFamily: 'Eina',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        text: "ai\n"),
                                    TextSpan(
                                      text: "Terms of Service",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Eina',
                                        fontWeight: FontWeight.bold,
                                        decorationColor: Colors.white,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => launchURL(
                                            "https://corgis.ai/terms"),
                                    ),
                                    const TextSpan(
                                      text: " and ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Eina',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Eina',
                                        fontWeight: FontWeight.bold,
                                        decorationColor: Colors.white,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => launchURL(
                                            "https://corgis.ai/privacy"),
                                    ),
                                  ]))))
                    ]))));
  }
}

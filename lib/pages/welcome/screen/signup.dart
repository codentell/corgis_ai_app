import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:corgis_ai_app/components/TyperAnimatedTextCustom.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:corgis_ai_app/main.dart';
import 'package:rive/rive.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';
import 'package:uuid/uuid.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  @override
  void initState() {
    super.initState();
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
            body: Container(
                color: const Color(0xFF0A062F),
                child: Column(children: [
                  Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0.0, end: 1.0),
                                  duration: const Duration(seconds: 1),
                                  builder: (context, value, child) {
                                    return Transform.scale(
                                        scale: value,
                                        child: const SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: RiveAnimation.network(
                                                "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/kody.riv",
                                                fit: BoxFit.cover,
                                                animations: ["idle"])));
                                  }),
                              Expanded(
                                  child: Column(children: [
                                CustomAnimationBuilder<double>(
                                    tween: Tween<double>(begin: 0.0, end: 1.0),
                                    duration: const Duration(milliseconds: 500),
                                    builder: (context, value, child) {
                                      return Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          alignment: Alignment.centerLeft,
                                          child: Transform.scale(
                                              scale: value,
                                              child: const Text.rich(TextSpan(
                                                  style: TextStyle(
                                                    color: Color(0xFFC371FE),
                                                    fontSize: 24,
                                                    fontFamily: 'Eina',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  text: '@',
                                                  children: <InlineSpan>[
                                                    TextSpan(
                                                        text: 'corgis',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 21,
                                                          fontFamily: 'Eina',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    TextSpan(
                                                        text: '.',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 21,
                                                          fontFamily: 'Eina',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    TextSpan(
                                                        text: 'ai',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFFEBF4C),
                                                          fontSize: 21,
                                                          fontFamily: 'Eina',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ))
                                                  ]))));
                                    }),
                                Container(
                                    margin: const EdgeInsets.only(left: 10),
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
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(children: [
                                      Expanded(
                                          child: AnimatedTextKit(
                                              totalRepeatCount: 1,
                                              animatedTexts: [
                                            TyperAnimatedTextCustom([
                                              const TextSpan(
                                                text: 'Hello ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontFamily: 'Eina',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: 'programming ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontFamily: 'Eina',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: 'language ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontFamily: 'Eina',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: 'or ',
                                                style: TextStyle(
                                                  color: Color(0xFFC371FE),
                                                  fontSize: 24,
                                                  fontFamily: 'Eina',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: 'technology ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontFamily: 'Eina',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: 'sparks ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontFamily: 'Eina',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: 'your ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontFamily: 'Eina',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: 'interest?',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontFamily: 'Eina',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                                speed: const Duration(
                                                    milliseconds: 70))
                                          ])),
                                    ])),
                              ])),
                            ]),
                      ])),
                ]))));
  }
}

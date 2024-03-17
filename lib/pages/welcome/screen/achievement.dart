import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:corgis_ai_app/components/TyperAnimatedTextCustom.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:rive/rive.dart';

class AchievementPage extends StatefulWidget {
  final bool disabled;
  final String goal;
  final Function selectAchievement;
  const AchievementPage(
      {super.key,
      required this.goal,
      required this.disabled,
      required this.selectAchievement});

  @override
  AchievementPageState createState() => AchievementPageState();
}

class AchievementPageState extends State<AchievementPage> {
  String? achievement;
  Map<String, String> achievements = {
    "Just for fun": "Wow! Here's what you can achieve!",
    "Prepare for interviews": "Boom! Gear up for interview success!",
    "Level up skills": "Yay! Prepare to unlock new levels of expertise!",
    "Grow a tech literacy": "Wow! Embark on a tech-filled adventure!",
    "Other": "Pow! Discover endless possibilities!"
  };

  @override
  initState() {
    //print(achievements[widget.goal]);

    setState(() {
      achievement = achievements[widget.goal];
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      widget.selectAchievement(achievements[widget.goal]);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            color: widget.disabled
                ? const Color(0xFF131F24)
                : const Color(0xFF0A062F),
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
                                      margin: const EdgeInsets.only(left: 10),
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
                                                      color: Color(0xFFFEBF4C),
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
                                  color:
                                      const Color(0xFF0E0657), //(0xFF0E0657),
                                  border: Border.all(
                                    color:
                                        Colors.white, //const Color(0xFF5046E4),
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
                                          TextSpan(
                                            text: achievement,
                                            style: const TextStyle(
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
                    Container(
                        margin: const EdgeInsets.only(
                            top: 20, right: 10, left: 10, bottom: 10),
                        height: 350,
                        child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color(0xFF0E0657),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                )),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(children: [
                                    Container(
                                        alignment: Alignment.topCenter,
                                        padding: const EdgeInsets.all(10),
                                        height: 70,
                                        width: 70,
                                        child: const RiveAnimation.asset(
                                            "assets/images/icons/chat.riv",
                                            fit: BoxFit.cover,
                                            animations: ["idle"])),
                                    Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: const Column(children: [
                                              Expanded(
                                                  child: Center(
                                                      child: Text(
                                                          "Converse with confidence!",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontFamily: 'Eina',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )))),
                                              Expanded(
                                                  flex: 2,
                                                  child: Wrap(children: [
                                                    Text(
                                                        "0+ AI-powered free interactive exercises",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14,
                                                          fontFamily: 'Eina',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ))
                                                  ]))
                                            ])))
                                  ]),
                                ),
                                Expanded(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                      Container(
                                          alignment: Alignment.topCenter,
                                          padding: const EdgeInsets.all(10),
                                          child: RiveAnimation.asset(
                                              "assets/images/icons/flash.riv",
                                              fit: BoxFit.cover,
                                              animations: ["idle"]),
                                          height: 70,
                                          width: 70),
                                      Expanded(
                                          child: Container(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(children: [
                                                Expanded(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                          textAlign:
                                                              TextAlign.left,
                                                          "Build a strong vocab!",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontFamily: 'Eina',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))),
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      child: Wrap(children: [
                                                        Text(
                                                            "0+ practical flash cards and code snippets",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Eina',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ))
                                                      ]),
                                                    ))
                                              ])))
                                    ])),
                                Expanded(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                      Container(
                                          alignment: Alignment.topCenter,
                                          padding: const EdgeInsets.all(10),
                                          child: RiveAnimation.asset(
                                              "assets/images/icons/watch.riv",
                                              fit: BoxFit.cover,
                                              animations: ["idle"]),
                                          height: 70,
                                          width: 70),
                                      Expanded(
                                          child: Container(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(children: [
                                                Expanded(
                                                    child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      textAlign: TextAlign.left,
                                                      "Develop a learning habit",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      child: Wrap(children: [
                                                        Text(
                                                            "Reminders, fun challenges and more.",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Eina',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ))
                                                      ]),
                                                    ))
                                              ])))
                                    ]))
                              ],
                            )))
                  ])),
            ])));
  }
}

// Whats is your goal? 
// Just for fun
// Example: Fun with corgis! Here's what you can achieve! 
// Prepare for interviews
// Level up skills
// Grow a tech literacy
// Other

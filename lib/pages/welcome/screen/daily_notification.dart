import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:corgis_ai_app/components/TyperAnimatedTextCustom.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:rive/rive.dart';

class DailyNotificationPage extends StatefulWidget {
  final bool disabled;
  final String dailyNotification;
  final Function selectDailyNotification;
  final List<Map> dailyNotifications;

  const DailyNotificationPage({
    super.key,
    required this.disabled,
    required this.dailyNotification,
    required this.dailyNotifications,
    required this.selectDailyNotification,
  });

  @override
  DailyNotificationPageState createState() => DailyNotificationPageState();
}

class DailyNotificationPageState extends State<DailyNotificationPage> {
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
                                      margin: const EdgeInsets.only(
                                          left: 10, bottom: 10),
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
                                          const TextSpan(
                                            text: 'What\'s ',
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
                                            text: 'daily ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: 'learning ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: 'goal?',
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
                    for (int i = 0; i < widget.dailyNotifications.length; i++)
                      Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          child: GestureDetector(
                              onTap: () => widget.selectDailyNotification(i),
                              child: CustomAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0.0, end: 1.0),
                                  duration: const Duration(milliseconds: 500),
                                  builder: (context, value, child) {
                                    return Transform.scale(
                                        scale: value,
                                        child: Column(children: [
                                          Container(
                                              height: 60,
                                              width: 400,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: widget
                                                                .dailyNotification ==
                                                            widget.dailyNotifications[
                                                                i]["text"]!
                                                        ? const Color(
                                                            0xFF2AFF32)
                                                        : Color(0xFF23197D),
                                                    width: 6,
                                                  ),
                                                  color: widget
                                                              .dailyNotification ==
                                                          widget.dailyNotifications[
                                                              i]["text"]!
                                                      ? Color(0xFF2AFF32)
                                                      : const Color(0xFF0A062F),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10),
                                                  )),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                            right: 10,
                                                            left: 10),
                                                        height: 50,
                                                        width: 50,
                                                        child: RiveAnimation.asset(
                                                            "assets/images/icons/${widget.dailyNotifications[i]["rank"]!}.riv",
                                                            fit: BoxFit.cover,
                                                            animations: const [
                                                              "idle"
                                                            ])),
                                                    widget.dailyNotification ==
                                                            widget.dailyNotifications[
                                                                i]["text"]!
                                                        ? Text(
                                                            widget.dailyNotifications[
                                                                i]["text"]!,
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF0A062F),
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'Eina',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ))
                                                        : AnimatedTextKit(
                                                            totalRepeatCount: 1,
                                                            animatedTexts: [
                                                                TyperAnimatedTextCustom(
                                                                    widget.dailyNotifications[
                                                                            i][
                                                                        "textSpan"]!,
                                                                    speed: const Duration(
                                                                        milliseconds:
                                                                            50))
                                                              ]),
                                                    SizedBox(
                                                        width: 100,
                                                        child: Text(
                                                            widget.dailyNotifications[
                                                                i]["rank"]!,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: widget
                                                                            .dailyNotification ==
                                                                        widget.dailyNotifications[i]
                                                                            [
                                                                            "text"]!
                                                                    ? const Color(
                                                                        0xFF0A062F)
                                                                    : Colors
                                                                        .white,
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    'Eina',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ])),
                                          Container(
                                            height: 15,
                                            width: 400,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: widget
                                                            .dailyNotification ==
                                                        widget.dailyNotifications[
                                                            i]["text"]!
                                                    ? const Color(0xFF69EC15)
                                                    : const Color(0xFF23197D),
                                                width: 3,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              color: widget.dailyNotification ==
                                                      widget.dailyNotifications[
                                                          i]["text"]!
                                                  ? const Color(0xFF69EC15)
                                                  : const Color(0xFF23197D),
                                            ),
                                          ),
                                        ]));
                                  }))),
                  ])),
            ])));
  }
}

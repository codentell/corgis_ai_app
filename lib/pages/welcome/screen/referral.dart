import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:corgis_ai_app/components/TyperAnimatedTextCustom.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:rive/rive.dart';

class ReferralPage extends StatefulWidget {
  final bool disabled;
  final String referral;
  const ReferralPage(
      {super.key, required this.referral, required this.disabled});

  @override
  ReferralPageState createState() => ReferralPageState();
}

class ReferralPageState extends State<ReferralPage> {
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
                                      child: widget.referral.isEmpty
                                          ? AnimatedTextKit(
                                              totalRepeatCount: 1,
                                              animatedTexts: [
                                                  TyperAnimatedTextCustom([
                                                    const TextSpan(
                                                      text: 'How ',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: 'did ',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: 'you ',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: 'hear ',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: 'about ',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: '@',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFC371FE),
                                                        fontSize: 24,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: 'corgis',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: '.',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: 'ai',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFFEBF4C),
                                                        fontSize: 24,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: '?',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                      speed: const Duration(
                                                          milliseconds: 70))
                                                ])
                                          : Text.rich(
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                letterSpacing: 0.0,
                                              ),
                                              TextSpan(
                                                  text: 'What programming',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontFamily: 'Eina',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  children: [
                                                    const TextSpan(
                                                      text: ' language ',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: 'or ',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFC371FE),
                                                        fontSize: 24,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: 'technology ',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: 'sparks ',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: 'your ',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                        text: 'interest?',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 24,
                                                          fontFamily: 'Eina',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ]))),
                                ])),
                          ])),
                        ]),
                    // for (int i = 0; i < widget.referrals.length; i++)
                    //   Container(
                    //       margin: const EdgeInsets.only(top: 10, bottom: 10),
                    //       child: GestureDetector(
                    //           onTap: () => widget.selectLanguage(i),
                    //           child: CustomAnimationBuilder<double>(
                    // tween: Tween<double>(begin: 0.0, end: 1.0),
                    // duration: const Duration(milliseconds: 500),
                    // builder: (context, value, child) {
                    //   return Transform.scale(
                    //       scale: value,
                    //       child: Column(children: [
                    //         Container(
                    //             height: 60,
                    //             width: 400,
                    //             decoration: BoxDecoration(
                    //                 border: Border.all(
                    //                   color: widget.referral ==
                    //                           widget.referrals[i]
                    //                               ["language"]!
                    //                       ? const Color(
                    //                           0xFF2AFF32)
                    //                       : Color(0xFF23197D),
                    //                   width: 6,
                    //                 ),
                    //                 color: widget.referral ==
                    //                         widget.referrals[i]
                    //                             ["language"]!
                    //                     ? Color(0xFF2AFF32)
                    //                     : const Color(0xFF0A062F),
                    //                 borderRadius:
                    //                     const BorderRadius.only(
                    //                   topRight:
                    //                       Radius.circular(10),
                    //                   topLeft:
                    //                       Radius.circular(10),
                    //                 )),
                    //             child: Row(children: [
                    //               Container(
                    //                   margin:
                    //                       const EdgeInsets.only(
                    //                           right: 10,
                    //                           left: 10),
                    //                   height: 50,
                    //                   width: 50,
                    //                   child: RiveAnimation.network(
                    //                       "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/${widget.languages[i]["name"]!}.riv",
                    //                       fit: BoxFit.cover,
                    //                       animations: const [
                    //                         "idle"
                    //                       ])),
                    //               widget.referral ==
                    //                       widget.referrals[i]
                    //                           ["language"]!
                    //                   ? Text(
                    //                       widget.referrals[i]
                    //                           ["name"]!,
                    //                       style: const TextStyle(
                    //                         color:
                    //                             Color(0xFF0A062F),
                    //                         fontSize: 30,
                    //                         fontFamily: 'Eina',
                    //                         fontWeight:
                    //                             FontWeight.bold,
                    //                       ))
                    //                   : AnimatedTextKit(
                    //                       totalRepeatCount: 1,
                    //                       animatedTexts: [
                    //                           TyperAnimatedTextCustom(
                    //                               widget.referrals[
                    //                                   i]["text"]!,
                    //                               speed: const Duration(
                    //                                   milliseconds:
                    //                                       50))
                    //                         ]),
                    //             ])),
                    //         Container(
                    //           height: 15,
                    //           width: 400,
                    //           decoration: BoxDecoration(
                    //             border: Border.all(
                    //               color: widget.referral ==
                    //                       widget.referrals[i]
                    //                           ["language"]!
                    //                   ? const Color(0xFF69EC15)
                    //                   : const Color(0xFF23197D),
                    //               width: 3,
                    //             ),
                    //             borderRadius:
                    //                 const BorderRadius.only(
                    //               bottomRight:
                    //                   Radius.circular(10),
                    //               bottomLeft: Radius.circular(10),
                    //             ),
                    //             color: widget.referral ==
                    //                     widget.referrals[i]
                    //                         ["language"]!
                    //                 ? const Color(0xFF69EC15)
                    //                 : const Color(0xFF23197D),
                    //           ),
                    //         ),
                    //       ]));
                    //}))),
                  ])),
            ])));
  }
}

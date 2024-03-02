import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:corgis_ai_app/components/TyperAnimatedTextCustom.dart';
import 'package:corgis_ai_app/components/progress.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:rive/rive.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  OnboardPageState createState() => OnboardPageState();
}

class OnboardPageState extends State<OnboardPage> {
  late double progress;
  late int page;
  late String language;

  @override
  void initState() {
    setState(() {
      progress = 0;
      page = 0;
      language = "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
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
                      Expanded(
                          flex: 5,
                          child: Container(
                            width: 200,
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2C2851),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ProgressBar(
                              currentValue: progress,
                            ),
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
                controller: controller,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int num) {
                  setState(() {
                    progress = num * 10;
                  });
                },
                children: [
                  SingleChildScrollView(
                      child: Container(
                          color: const Color(0xFF0A062F),
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
                                                            left: 10),
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
                                                                  ))
                                                            ]))));
                                              }),
                                          Container(
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
                                              child: Row(children: [
                                                Expanded(
                                                    child: AnimatedTextKit(
                                                        totalRepeatCount: 1,
                                                        animatedTexts: [
                                                      TyperAnimatedTextCustom([
                                                        TextSpan(
                                                          text: 'What ',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontFamily: 'Eina',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: 'programming ',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontFamily: 'Eina',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: 'language ',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontFamily: 'Eina',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: 'or ',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFC371FE),
                                                            fontSize: 24,
                                                            fontFamily: 'Eina',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: 'technology ',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontFamily: 'Eina',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: 'sparks ',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontFamily: 'Eina',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: 'your ',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontFamily: 'Eina',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: 'interest?',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontFamily: 'Eina',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )
                                                      ],
                                                          speed: const Duration(
                                                              milliseconds: 70))
                                                    ]))
                                              ])),
                                        ])),
                                      ]),
                                  Container(
                                      margin: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              language = "py";
                                            });
                                            print(language);
                                          },
                                          child: CustomAnimationBuilder<double>(
                                              tween: Tween<double>(
                                                  begin: 0.0, end: 1.0),
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              builder: (context, value, child) {
                                                return Transform.scale(
                                                    scale: value,
                                                    child: Column(children: [
                                                      Container(
                                                          height: 60,
                                                          width: 400,
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: language ==
                                                                            "py"
                                                                        ? Color(
                                                                            0xFF2AFF32)
                                                                        : Color(
                                                                            0xFF23197D),
                                                                    width: 6,
                                                                  ),
                                                                  color: language ==
                                                                          "py"
                                                                      ? Color(
                                                                          0xFF2AFF32)
                                                                      : Colors
                                                                          .transparent,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                  )),
                                                          child: Row(children: [
                                                            Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            10,
                                                                        left:
                                                                            10),
                                                                child: RiveAnimation.network(
                                                                    "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/python.riv",
                                                                    fit: BoxFit.cover,
                                                                    animations: [
                                                                      "idle"
                                                                    ]),
                                                                height: 50,
                                                                width: 50),
                                                            language == "py"
                                                                ? Text("python",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFF0A062F),
                                                                      fontSize:
                                                                          30,
                                                                      fontFamily:
                                                                          'Eina',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ))
                                                                : AnimatedTextKit(
                                                                    totalRepeatCount:
                                                                        1,
                                                                    animatedTexts: [
                                                                        TyperAnimatedTextCustom([
                                                                          TextSpan(
                                                                              text: "py",
                                                                              style: TextStyle(
                                                                                color: Color(0xFF20A6F9),
                                                                                fontSize: 30,
                                                                                fontFamily: 'Eina',
                                                                                fontWeight: FontWeight.bold,
                                                                              )),
                                                                          TextSpan(
                                                                              text: "thon",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 30,
                                                                                fontFamily: 'Eina',
                                                                                fontWeight: FontWeight.bold,
                                                                              ))
                                                                        ], speed: const Duration(milliseconds: 50))
                                                                      ]),
                                                          ])),
                                                      Container(
                                                        height: 15,
                                                        width: 400,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: language ==
                                                                    "py"
                                                                ? Color(
                                                                    0xFF69EC15)
                                                                : const Color(
                                                                    0xFF23197D),
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
                                                          color: language ==
                                                                  "py"
                                                              ? Color(
                                                                  0xFF69EC15)
                                                              : const Color(
                                                                  0xFF23197D),
                                                        ),
                                                      ),
                                                    ]));
                                              }))),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              language = "js";
                                            });
                                            print(language);
                                          },
                                          child: CustomAnimationBuilder<double>(
                                              tween: Tween<double>(
                                                  begin: 0.0, end: 1.0),
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              builder: (context, value, child) {
                                                return Transform.scale(
                                                    scale: value,
                                                    child: Column(children: [
                                                      Container(
                                                          height: 60,
                                                          width: 400,
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Color(
                                                                        0xFF23197D),
                                                                    width: 6, //
                                                                  ),
                                                                  color: Colors
                                                                      .transparent,
                                                                  //  Color(
                                                                  //     0xFFA2FF66),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                  )),
                                                          child: Row(children: [
                                                            Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            10,
                                                                        left:
                                                                            10),
                                                                child: RiveAnimation.network(
                                                                    "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/javascript.riv",
                                                                    fit: BoxFit.cover,
                                                                    animations: [
                                                                      "idle"
                                                                    ]),
                                                                height: 50,
                                                                width: 50),
                                                            AnimatedTextKit(
                                                                totalRepeatCount:
                                                                    1,
                                                                animatedTexts: [
                                                                  TyperAnimatedTextCustom([
                                                                    TextSpan(
                                                                        text:
                                                                            "j",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFFFAEC36),
                                                                          fontSize:
                                                                              30,
                                                                          fontFamily:
                                                                              'Eina',
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "ava",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              30,
                                                                          fontFamily:
                                                                              'Eina',
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "s",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFFFAEC36),
                                                                          fontSize:
                                                                              30,
                                                                          fontFamily:
                                                                              'Eina',
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "cript",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              30,
                                                                          fontFamily:
                                                                              'Eina',
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ))
                                                                  ],
                                                                      speed: const Duration(
                                                                          milliseconds:
                                                                              50))
                                                                ]),
                                                          ])),
                                                      Container(
                                                        height: 15,
                                                        width: 400,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: const Color(
                                                                0xFF23197D),
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
                                                          color: const Color(
                                                              0xFF23197D),
                                                        ),
                                                      ),
                                                    ]));
                                              }))),
                                  Container(color: Colors.green, height: 100),
                                  Container(color: Colors.yellow, height: 100),
                                  Container(color: Colors.red, height: 100),
                                  Container(color: Colors.blue, height: 100),
                                  Container(color: Colors.green, height: 100),
                                  Container(color: Colors.yellow, height: 100),
                                  Container(color: Colors.red, height: 100)
                                ])),
                          ]))),
                  Container(color: Colors.purple, height: 100),
                ]),
            //   PageView(
            //       controller: controller,
            //       scrollDirection: Axis.vertical,
            //       physics: const NeverScrollableScrollPhysics(),
            //       onPageChanged: (int num) {
            //         setState(() {
            //           progress = num * 10;
            //         });
            //       },
            //       children: [
            //         Container(
            //           color: const Color(0xFF0A062F),
            //           alignment: Alignment.center,
            //           child: Center(
            //               child: Container(
            //             padding: const EdgeInsets.all(20),
            //             child: Column(children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   CustomAnimationBuilder<double>(
            //                       tween: Tween<double>(begin: 0.0, end: 1.0),
            //                       duration: const Duration(seconds: 1),
            //                       builder: (context, value, child) {
            //                         return Transform.scale(
            //                             scale: value,
            //                             child: SizedBox(
            //                                 height: 80,
            //                                 width: 80,
            //                                 child: const RiveAnimation.network(
            //                                     "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/kody.riv",
            //                                     fit: BoxFit.cover,
            //                                     animations: ["idle"])));
            //                       }),
            //                   Expanded(
            //                       child: Column(children: [
            //                     CustomAnimationBuilder<double>(
            //                         tween: Tween<double>(begin: 0.0, end: 1.0),
            //                         duration: const Duration(milliseconds: 500),
            //                         builder: (context, value, child) {
            //                           return Container(
            //                               margin:
            //                                   const EdgeInsets.only(left: 10),
            //                               alignment: Alignment.centerLeft,
            //                               child: Transform.scale(
            //                                   scale: value,
            //                                   child: Text.rich(TextSpan(
            //                                       style: TextStyle(
            //                                         color:
            //                                             const Color(0xFFC371FE),
            //                                         fontSize: 25,
            //                                         fontFamily: 'Eina',
            //                                         fontWeight: FontWeight.bold,
            //                                       ),
            //                                       text: '@',
            //                                       children: <InlineSpan>[
            //                                         TextSpan(
            //                                             text: 'corgis',
            //                                             style: TextStyle(
            //                                               color: Colors.white,
            //                                               fontSize: 20,
            //                                               fontFamily: 'Eina',
            //                                               fontWeight:
            //                                                   FontWeight.bold,
            //                                             )),
            //                                         TextSpan(
            //                                             text: '.',
            //                                             style: TextStyle(
            //                                               color: Colors.white,
            //                                               fontSize: 20,
            //                                               fontFamily: 'Eina',
            //                                               fontWeight:
            //                                                   FontWeight.bold,
            //                                             )),
            //                                         TextSpan(
            //                                             text: 'ai',
            //                                             style: TextStyle(
            //                                               color:
            //                                                   Color(0xFFFEBF4C),
            //                                               fontSize: 20,
            //                                               fontFamily: 'Eina',
            //                                               fontWeight:
            //                                                   FontWeight.bold,
            //                                             ))
            //                                       ]))));
            //                         }),
            //                     Container(
            //                         margin: const EdgeInsets.only(left: 10),
            //                         padding: const EdgeInsets.all(10),
            //                         decoration: BoxDecoration(
            //                           color: const Color(
            //                               0xFF0E0657), //(0xFF0E0657),
            //                           border: Border.all(
            //                             color: Colors
            //                                 .white, //const Color(0xFF5046E4),
            //                             width: 4,
            //                           ),
            //                           //color: Colors.white,
            //                           borderRadius: BorderRadius.circular(10),
            //                         ),
            //                         child: Row(children: [
            //                           Expanded(
            //                               child: AnimatedTextKit(
            //                                   totalRepeatCount: 1,
            //                                   animatedTexts: [
            //                                 TyperAnimatedTextCustom([
            //                                   TextSpan(
            //                                     text: 'What ',
            //                                     style: TextStyle(
            //                                       color: Colors.white,
            //                                       fontSize: 20,
            //                                       fontFamily: 'Eina',
            //                                       fontWeight: FontWeight.bold,
            //                                     ),
            //                                   ),
            //                                   TextSpan(
            //                                     text: 'programming ',
            //                                     style: TextStyle(
            //                                       color: Colors.white,
            //                                       fontSize: 20,
            //                                       fontFamily: 'Eina',
            //                                       fontWeight: FontWeight.bold,
            //                                     ),
            //                                   ),
            //                                   TextSpan(
            //                                     text: 'language ',
            //                                     style: TextStyle(
            //                                       color: Colors.white,
            //                                       fontSize: 20,
            //                                       fontFamily: 'Eina',
            //                                       fontWeight: FontWeight.bold,
            //                                     ),
            //                                   ),
            //                                   TextSpan(
            //                                     text: 'or ',
            //                                     style: TextStyle(
            //                                       color: Color(0xFFC371FE),
            //                                       fontSize: 20,
            //                                       fontFamily: 'Eina',
            //                                       fontWeight: FontWeight.bold,
            //                                     ),
            //                                   ),
            //                                   TextSpan(
            //                                     text: 'technology ',
            //                                     style: TextStyle(
            //                                       color: Colors.white,
            //                                       fontSize: 20,
            //                                       fontFamily: 'Eina',
            //                                       fontWeight: FontWeight.bold,
            //                                     ),
            //                                   ),
            //                                   TextSpan(
            //                                     text: 'sparks ',
            //                                     style: TextStyle(
            //                                       color: Colors.white,
            //                                       fontSize: 20,
            //                                       fontFamily: 'Eina',
            //                                       fontWeight: FontWeight.bold,
            //                                     ),
            //                                   ),
            //                                   TextSpan(
            //                                     text: 'your ',
            //                                     style: TextStyle(
            //                                       color: Colors.white,
            //                                       fontSize: 20,
            //                                       fontFamily: 'Eina',
            //                                       fontWeight: FontWeight.bold,
            //                                     ),
            //                                   ),
            //                                   TextSpan(
            //                                     text: 'interest?',
            //                                     style: TextStyle(
            //                                       color: Colors.white,
            //                                       fontSize: 20,
            //                                       fontFamily: 'Eina',
            //                                       fontWeight: FontWeight.bold,
            //                                     ),
            //                                   )
            //                                 ],
            //                                     speed: const Duration(
            //                                         milliseconds: 70))
            //                               ]))
            //                         ])),
            //                   ])),
            //                 ],
            //               ),
            //             ]),
            //           )),
            //         ),
            //       ])
            // ])),

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
                                setState(() {
                                  page += 1;
                                });
                                controller.animateToPage(page,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
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
                                                        color:
                                                            Color(0xFFB9FF8C),
                                                      ),
                                                    ),
                                                    const Center(
                                                        child: Text(
                                                      "continue",
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
                                                        color:
                                                            Color(0xFFB9FF8C),
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

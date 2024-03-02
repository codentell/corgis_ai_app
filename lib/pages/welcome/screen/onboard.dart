import 'package:animated_text_kit/animated_text_kit.dart';
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

  @override
  void initState() {
    setState(() {
      progress = 0;
      page = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: Container(
                  height: 70,
                  backgroundColor: const Color(0xFF0A062F),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 100,
                          height: 50,
                          color: const Color(0xFF1B282E),
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
                              color: const Color(0xFF131F24),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ProgressBar(
                              currentValue: progress,
                            ),
                          )),
                      Container(
                        width: 100,
                        height: 50,
                        color: const Color(0xFF1B282E),
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
                  Container(
                    color: const Color(0xFF131F24),
                    alignment: Alignment.center,
                    child: Center(
                        child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0.0, end: 1.0),
                              duration: const Duration(seconds: 1),
                              builder: (context, value, child) {
                                return Transform.scale(
                                    scale: value,
                                    child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width <
                                                    500
                                                ? 80
                                                : 160,
                                        width:
                                            MediaQuery.of(context).size.width <
                                                    500
                                                ? 80
                                                : 160,
                                        child: const RiveAnimation.network(
                                            "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/kody.riv",
                                            fit: BoxFit.cover,
                                            animations: ["idle"])));
                              }),
                          Expanded(
                              child: Column(children: [
                            Container(
                                margin: const EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                child: Text.rich(TextSpan(
                                    style: TextStyle(
                                      color: const Color(0xFFC371FE),
                                      fontSize:
                                          MediaQuery.of(context).size.width <
                                                  500
                                              ? 18
                                              : 25,
                                      fontFamily: 'Eina',
                                      fontWeight: FontWeight.w300,
                                    ),
                                    text: '@',
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: 'corgis',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width <
                                                    500
                                                ? 18
                                                : 25,
                                            fontFamily: 'Eina',
                                            fontWeight: FontWeight.w300,
                                          ))
                                    ]))),
                            Container(
                                margin: const EdgeInsets.only(left: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.transparent, //(0xFF0E0657),
                                  border: Border.all(
                                    color: const Color(0xFF5046E4),
                                    width: 4,
                                  ),
                                  //color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(children: [
                                  Expanded(
                                      child: MediaQuery.of(context).size.width <
                                              500
                                          ? AnimatedTextKit(
                                              totalRepeatCount: 1,
                                              animatedTexts: [
                                                  TyperAnimatedText(
                                                      // currentDialogue['message'],
                                                      "Hello World! I'm Kody your coding guide! Ready to play?",
                                                      textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width <
                                                                500
                                                            ? 20
                                                            : 30,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      speed: const Duration(
                                                          milliseconds: 50))
                                                ])
                                          : AnimatedTextKit(
                                              totalRepeatCount: 1,
                                              animatedTexts: [
                                                  TyperAnimatedText(
                                                      // currentDialogue['message'],
                                                      "Hello World! I'm Kody your coding guide! Ready to play?",
                                                      textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width <
                                                                500
                                                            ? 20
                                                            : 30,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      speed: const Duration(
                                                          milliseconds: 50))
                                                ]))
                                ])),
                          ])),
                        ],
                      ),
                    )),
                  ),
                  Container(
                    color: const Color(0xFF131F24),
                    alignment: Alignment.center,
                    child: Center(
                        child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0.0, end: 1.0),
                              duration: const Duration(seconds: 1),
                              builder: (context, value, child) {
                                return Transform.scale(
                                    scale: value,
                                    child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width <
                                                    500
                                                ? 80
                                                : 160,
                                        width:
                                            MediaQuery.of(context).size.width <
                                                    500
                                                ? 80
                                                : 160,
                                        child: const RiveAnimation.network(
                                            "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/kody.riv",
                                            fit: BoxFit.cover,
                                            animations: ["idle"])));
                              }),
                          Expanded(
                              child: Column(children: [
                            Container(
                                margin: const EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                child: Text.rich(TextSpan(
                                    style: TextStyle(
                                      color: const Color(0xFFC371FE),
                                      fontSize:
                                          MediaQuery.of(context).size.width <
                                                  500
                                              ? 18
                                              : 25,
                                      fontFamily: 'Eina',
                                      fontWeight: FontWeight.w300,
                                    ),
                                    text: '@',
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: 'corgis',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width <
                                                    500
                                                ? 18
                                                : 25,
                                            fontFamily: 'Eina',
                                            fontWeight: FontWeight.w300,
                                          ))
                                    ]))),
                            Container(
                                margin: const EdgeInsets.only(left: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.transparent, //(0xFF0E0657),
                                  border: Border.all(
                                    color: const Color(0xFF5046E4),
                                    width: 4,
                                  ),
                                  //color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(children: [
                                  Expanded(
                                      child: MediaQuery.of(context).size.width <
                                              500
                                          ? AnimatedTextKit(
                                              totalRepeatCount: 1,
                                              animatedTexts: [
                                                  TyperAnimatedText(
                                                      "What would you like to learn?",
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        //: 30,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      speed: const Duration(
                                                          milliseconds: 50))
                                                ])
                                          : const Text(
                                              "What would you like to learn?",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                                fontFamily: 'Eina',
                                                fontWeight: FontWeight.bold,
                                              )))
                                ])),
                          ])),
                        ],
                      ),
                    )),
                  ),
                ]),
            bottomNavigationBar: Container(
                alignment: Alignment.center,
                height: 100,
                color: const Color(0xFF1B282E),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            GestureDetector(
                                onTap: () {
                                  //print(currentDialogue);
                                  // if (checkQuestions(question1)) {
                                  //   setState(() {
                                  //     page += 1;
                                  //     //currentDialogue = choice['next'];
                                  //   });
                                  setState(() {
                                    page += 1;
                                  });
                                  controller.animateToPage(page,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                  // }
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
                                                    // color: (question1 ==
                                                    //             "yes" ||
                                                    //         question1 == "no")
                                                    //     ? Color(0xFFA2FF66)
                                                    //     : Color(0xFF202F36),
                                                    borderRadius:
                                                        BorderRadius.only(
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
                                                                0xFFB9FF8C)
                                                            // color: (question1 ==
                                                            //             "yes" ||
                                                            //         question1 ==
                                                            //             "no")
                                                            //     ? Color(
                                                            //         0xFFB9FF8C)
                                                            //     : Color(
                                                            //         0xFF202F36),
                                                            ),
                                                      ),
                                                      const Center(
                                                          child: Text(
                                                        "continue",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF1a1e4c),
                                                          // color: (question1 ==
                                                          //             "yes" ||
                                                          //         question1 ==
                                                          //             "no")
                                                          //     ? Color(
                                                          //         0xFF1a1e4c)
                                                          //     : Color(
                                                          //         0xFF49C1F9),
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
                                                                0xFFB9FF8C)
                                                            // color: (question1 ==
                                                            //             "yes" ||
                                                            //         question1 ==
                                                            //             "no")
                                                            //     ? Color(
                                                            //         0xFFB9FF8C)
                                                            //     : Color(
                                                            //         0xFF202F36),
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
                                                    color:
                                                        const Color(0xFF69EC15),
                                                    // color: (question1 == "yes" ||
                                                    //         question1 == "no")
                                                    //     ? Color(0xFF69EC15)
                                                    //     : Color(0xFF384650),
                                                    width: 3,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                  color: const Color(0xFF69EC15)
                                                  // color: (question1 == "yes" ||
                                                  //         question1 == "no")
                                                  //     ? Color(0xFF69EC15)
                                                  //     : Color(0xFF384650),
                                                  ),
                                            ),
                                          ]));
                                    }))
                          ]))
                    ])),
            backgroundColor: const Color(0xFF131F24)));
  }
}

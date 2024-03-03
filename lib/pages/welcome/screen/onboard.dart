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
  late bool disabled;
  late String language;
  late List<Map> languages;

  @override
  void initState() {
    setState(() {
      disabled = true;
      progress = 0;
      page = 0;
      language = "";
      languages = [
        {
          "name": "python",
          "language": "py",
          "text": [
            const TextSpan(
                text: "py",
                style: TextStyle(
                  color: Color(0xFF20A6F9),
                  fontSize: 30,
                  fontFamily: 'Eina',
                  fontWeight: FontWeight.bold,
                )),
            const TextSpan(
                text: "thon",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Eina',
                  fontWeight: FontWeight.bold,
                ))
          ]
        },
        {
          "name": "javascript",
          "language": "js",
          "text": [
            const TextSpan(
                text: "j",
                style: TextStyle(
                  color: Color(0xFFFAEC36),
                  fontSize: 30,
                  fontFamily: 'Eina',
                  fontWeight: FontWeight.bold,
                )),
            const TextSpan(
                text: "ava",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Eina',
                  fontWeight: FontWeight.bold,
                )),
            const TextSpan(
                text: "s",
                style: TextStyle(
                  color: Color(0xFFFAEC36),
                  fontSize: 30,
                  fontFamily: 'Eina',
                  fontWeight: FontWeight.bold,
                )),
            const TextSpan(
                text: "cript",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Eina',
                  fontWeight: FontWeight.bold,
                ))
          ]
        },
        {
          "name": "mojo",
          "language": "mojo",
          "text": [
            const TextSpan(
                text: "mojo",
                style: TextStyle(
                  color: Color(0xFFFF5858),
                  fontSize: 30,
                  fontFamily: 'Eina',
                  fontWeight: FontWeight.bold,
                ))
          ]
        },
        {
          "name": "rust",
          "language": "rs",
          "text": [
            const TextSpan(
                text: "r",
                style: TextStyle(
                  color: Color(0xFFFFBF75),
                  fontSize: 30,
                  fontFamily: 'Eina',
                  fontWeight: FontWeight.bold,
                )),
            TextSpan(
                text: "u",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Eina',
                  fontWeight: FontWeight.bold,
                )),
            TextSpan(
                text: "s",
                style: TextStyle(
                  color: Color(0xFFFFBF75),
                  fontSize: 30,
                  fontFamily: 'Eina',
                  fontWeight: FontWeight.bold,
                )),
            TextSpan(
                text: "t",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Eina',
                  fontWeight: FontWeight.bold,
                ))
          ]
        },
        {
          "name": "postgresql",
          "language": "psql",
          "text": [
            const TextSpan(
                text: "p",
                style: TextStyle(
                  color: Color(0xFF22C2FF),
                  fontSize: 30,
                  fontFamily: 'Eina',
                  fontWeight: FontWeight.bold,
                )),
            const TextSpan(
                text: "ostgre",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Eina',
                  fontWeight: FontWeight.bold,
                )),
            const TextSpan(
                text: "sql",
                style: TextStyle(
                  color: Color(0xFF22C2FF),
                  fontSize: 30,
                  fontFamily: 'Eina',
                  fontWeight: FontWeight.bold,
                ))
          ]
        }
      ];
    });
    super.initState();
  }

  setupColors(language) {
    if (language == "py") {
      return const Color(0xFF20A6F9);
    } else if (language == "js") {
      return const Color(0xFFFAEC36);
    } else if (language == "mojo") {
      return const Color(0xFFFF5858);
    } else if (language == "rs") {
      return const Color(0xFFFFBF75);
    } else if (language == "psql") {
      return const Color(0xFF22C2FF);
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return SafeArea(
        child: Scaffold(
            backgroundColor:
                disabled ? const Color(0xFF1B282E) : const Color(0xFF0A062F),
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: Container(
                  height: 70,
                  color: disabled
                      ? const Color(0xFF1B282E)
                      : const Color(0xFF0A062F),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          color: disabled
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
                                        controller.animateToPage(page - 1,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeInOut),
                                        setState(() {
                                          page -= 1;
                                        })
                                      }
                                  })),
                      Expanded(
                          flex: 5,
                          child: Container(
                            width: 200,
                            height: 20,
                            decoration: BoxDecoration(
                              color: disabled
                                  ? const Color(0xFF131F24)
                                  : const Color(0xFF2C2851),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ProgressBar(
                              currentValue: progress,
                            ),
                          )),
                      Container(
                        width: 50,
                        height: 50,
                        color: disabled
                            ? const Color(0xFF1B282E)
                            : const Color(0xFF0A062F),
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
                          color: disabled
                              ? const Color(0xFF131F24)
                              : const Color(0xFF0A062F),
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
                                                    child: language.isEmpty
                                                        ? AnimatedTextKit(
                                                            totalRepeatCount: 1,
                                                            animatedTexts: [
                                                                TyperAnimatedTextCustom([
                                                                  const TextSpan(
                                                                    text:
                                                                        'What ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'Eina',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text:
                                                                        'programming ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'Eina',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text:
                                                                        'language ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'Eina',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text: 'or ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFFC371FE),
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'Eina',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text:
                                                                        'technology ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'Eina',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text:
                                                                        'sparks ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'Eina',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text:
                                                                        'your ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'Eina',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text:
                                                                        'interest?',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'Eina',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                                    speed: const Duration(
                                                                        milliseconds:
                                                                            70))
                                                              ])
                                                        : Text.rich(
                                                            textAlign:
                                                                TextAlign.start,
                                                            style:
                                                                const TextStyle(
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                            TextSpan(
                                                                text:
                                                                    'What programming',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 24,
                                                                  fontFamily:
                                                                      'Eina',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                children: [
                                                                  const TextSpan(
                                                                    text:
                                                                        ' language ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'Eina',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text: 'or ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFFC371FE),
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'Eina',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text:
                                                                        'technology ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'Eina',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text:
                                                                        'sparks ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'Eina',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text:
                                                                        'your ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'Eina',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                      text:
                                                                          'interest?',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            24,
                                                                        fontFamily:
                                                                            'Eina',
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      )),
                                                                  TextSpan(
                                                                      text:
                                                                          " $language",
                                                                      style:
                                                                          TextStyle(
                                                                        color: setupColors(
                                                                            language),
                                                                        fontSize:
                                                                            24,
                                                                        fontFamily:
                                                                            'Eina',
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ))
                                                                ]))),
                                              ])),
                                        ])),
                                      ]),
                                  for (int i = 0; i < languages.length; i++)
                                    Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                disabled = false;
                                                language =
                                                    languages[i]["language"]!;
                                              });
                                              print(language);
                                            },
                                            child:
                                                CustomAnimationBuilder<double>(
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
                                                                    height: 60,
                                                                    width: 400,
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                          color: language == languages[i]["language"]!
                                                                              ? const Color(0xFF2AFF32)
                                                                              : Color(0xFF23197D),
                                                                          width:
                                                                              6,
                                                                        ),
                                                                        color: language == languages[i]["language"]! ? Color(0xFF2AFF32) : const Color(0xFF0A062F),
                                                                        borderRadius: const BorderRadius.only(
                                                                          topRight:
                                                                              Radius.circular(10),
                                                                          topLeft:
                                                                              Radius.circular(10),
                                                                        )),
                                                                    child: Row(children: [
                                                                      Container(
                                                                          margin: const EdgeInsets
                                                                              .only(
                                                                              right:
                                                                                  10,
                                                                              left:
                                                                                  10),
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          child: RiveAnimation.network(
                                                                              "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/${languages[i]["name"]!}.riv",
                                                                              fit: BoxFit.cover,
                                                                              animations: const [
                                                                                "idle"
                                                                              ])),
                                                                      language ==
                                                                              languages[i]["language"]!
                                                                          ? Text(languages[i]["name"]!,
                                                                              style: const TextStyle(
                                                                                color: Color(0xFF0A062F),
                                                                                fontSize: 30,
                                                                                fontFamily: 'Eina',
                                                                                fontWeight: FontWeight.bold,
                                                                              ))
                                                                          : AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
                                                                              TyperAnimatedTextCustom(languages[i]["text"]!, speed: const Duration(milliseconds: 50))
                                                                            ]),
                                                                    ])),
                                                                Container(
                                                                  height: 15,
                                                                  width: 400,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: language ==
                                                                              languages[i][
                                                                                  "language"]!
                                                                          ? const Color(
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
                                                                            languages[i][
                                                                                "language"]!
                                                                        ? const Color(
                                                                            0xFF69EC15)
                                                                        : const Color(
                                                                            0xFF23197D),
                                                                  ),
                                                                ),
                                                              ]));
                                                    }))),
                                ])),
                          ]))),
                  Container(color: Colors.purple, height: 100),
                  Container(color: Colors.blue, height: 100),
                ]),
            bottomNavigationBar: Container(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 20),
                height: 125,
                color: disabled
                    ? const Color(0xFF1B282E)
                    : const Color(0xFF0A062F),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Expanded(
                          child: GestureDetector(
                              onTap: () {
                                if (disabled == false) {
                                  setState(() {
                                    page += 1;
                                    disabled = true;
                                  });
                                  controller.animateToPage(page,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                }
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
                                                  color: disabled
                                                      ? const Color(0xFF202F36)
                                                      : Color(0xFFA2FF66),
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
                                                        color: disabled
                                                            ? const Color(
                                                                0xFF202F36)
                                                            : const Color(
                                                                0xFFB9FF8C),
                                                      ),
                                                    ),
                                                    Center(
                                                        child: Text(
                                                      "continue",
                                                      style: TextStyle(
                                                        color: disabled
                                                            ? const Color(
                                                                0xFF49C1F9)
                                                            : const Color(
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
                                                        color: disabled
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
                                                color: disabled
                                                    ? const Color(0xFF384650)
                                                    : const Color(0xFF69EC15),
                                                width: 3,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              color: disabled
                                                  ? const Color(0xFF384650)
                                                  : const Color(0xFF69EC15),
                                            ),
                                          ),
                                        ]));
                                  }))),
                    ])))));
  }
}

import 'package:flutter/material.dart';
import 'package:corgis_ai_app/main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:corgis_ai_app/components/TyperAnimatedTextCustom.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:rive/rive.dart';

class QuestPage extends StatefulWidget {
  final bool disabled;
  final List<Map> quests;
  final String quest;
  final Function selectQuest;
  final String language;

  const QuestPage(
      {super.key,
      required this.disabled,
      required this.quest,
      required this.quests,
      required this.selectQuest,
      required this.language});

  @override
  QuestPageState createState() => QuestPageState();
}

class QuestPageState extends State<QuestPage> {
  late String language;

  @override
  initState() {
    if (widget.language == "py") {
      language = "python";
    }

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
                                    color: Colors.white,
                                    width: 4,
                                  ),

                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(children: [
                                  Expanded(
                                      child: AnimatedTextKit(
                                          totalRepeatCount: 1,
                                          animatedTexts: [
                                        TyperAnimatedTextCustom([
                                          TextSpan(
                                            text:
                                                'Let\'s get started with your first $language quest!',
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
                    for (int i = 0; i < 2; i++)
                      Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          child: GestureDetector(
                              onTap: () => widget.selectQuest(i),
                              child: CustomAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0.0, end: 1.0),
                                  duration: const Duration(milliseconds: 500),
                                  builder: (context, value, child) {
                                    return Transform.scale(
                                        scale: value,
                                        child: Column(children: [
                                          Container(
                                              height: 150,
                                              width: 400,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: widget.quest ==
                                                            widget.quests[i]
                                                                ["name"]!
                                                        ? const Color(
                                                            0xFF2AFF32)
                                                        : const Color(
                                                            0xFF23197D),
                                                    width: 6,
                                                  ),
                                                  color: widget.quest ==
                                                          widget.quests[i]
                                                              ["name"]!
                                                      ? const Color(0xFF2AFF32)
                                                      : const Color(0xFF0A062F),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10),
                                                  )),
                                              child: Row(children: [
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            left: 10),
                                                    height: 70,
                                                    width: 70,
                                                    child: RiveAnimation.network(
                                                        "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/${widget.quests[i]["name"]!}.riv",
                                                        fit: BoxFit.cover,
                                                        animations: const [
                                                          "idle"
                                                        ])),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                              child: Center(
                                                                  child: widget
                                                                              .quest ==
                                                                          widget.quests[i]
                                                                              [
                                                                              "name"]!
                                                                      ? Text(
                                                                          widget.quests[i]
                                                                              [
                                                                              "title"]!,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                const Color(0xFF23197D),
                                                                            fontSize:
                                                                                16,
                                                                            fontFamily:
                                                                                'Eina',
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ))
                                                                      : AnimatedTextKit(
                                                                          totalRepeatCount:
                                                                              1,
                                                                          animatedTexts: [
                                                                              TyperAnimatedTextCustom(widget.quests[i]["text"]!, speed: const Duration(milliseconds: 50))
                                                                            ]))),
                                                          Expanded(
                                                              child: widget
                                                                          .quest ==
                                                                      widget.quests[
                                                                              i]
                                                                          [
                                                                          "name"]!
                                                                  ? Text(
                                                                      widget
                                                                          .quests[
                                                                              i]
                                                                              [
                                                                              "description"]!
                                                                          .replaceAll(
                                                                              "<language>",
                                                                              language),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: const Color(
                                                                            0xFF23197D),
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'Eina',
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ))
                                                                  : Text(
                                                                      widget
                                                                          .quests[
                                                                              i]
                                                                              [
                                                                              "description"]!
                                                                          .replaceAll(
                                                                              "<language>",
                                                                              language),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'Eina',
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      softWrap:
                                                                          true,
                                                                    )),
                                                        ])),
                                              ])),
                                          Container(
                                            height: 15,
                                            width: 400,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: widget.quest ==
                                                        widget.quests[i]
                                                            ["name"]!
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
                                              color: widget.quest ==
                                                      widget.quests[i]["name"]!
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

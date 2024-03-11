import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:corgis_ai_app/components/TyperAnimatedTextCustom.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'dart:math';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';

class LevelPage extends StatefulWidget {
  final int level;
  final Function selectLevel;
  final bool disabled;
  const LevelPage({
    super.key,
    required this.level,
    required this.disabled,
    required this.selectLevel,
  });

  @override
  LevelPageState createState() => LevelPageState();
}

class LevelPageState extends State<LevelPage> {
  double posX = 0.0;
  final int breakpoints = 5;
  late int selectedLevel;
  SMIInput<double>? levelInput;
  late bool isDragging = false;
  late double maxWidth = 400;
  late double segmentWidth = maxWidth / (breakpoints);

  double deg2rad(double deg) => deg * pi / 180;

  initState() {
    setState(() {
      selectedLevel = widget.level;
      posX = (2 * segmentWidth).clamp(0, maxWidth - 50);
    });
    super.initState();
  }

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'game');
    artboard.addController(controller!);

    levelInput = controller.findInput<double>('level') as SMINumber;
    print("levelInput");
    print(levelInput?.value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 140,
            margin: const EdgeInsets.all(10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, value, child) {
                      return Container(
                          margin: const EdgeInsets.only(left: 10, bottom: 10),
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
                                          fontWeight: FontWeight.bold,
                                        )),
                                    TextSpan(
                                        text: '.',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 21,
                                          fontFamily: 'Eina',
                                          fontWeight: FontWeight.bold,
                                        )),
                                    TextSpan(
                                        text: 'ai',
                                        style: TextStyle(
                                          color: Color(0xFFFEBF4C),
                                          fontSize: 21,
                                          fontFamily: 'Eina',
                                          fontWeight: FontWeight.bold,
                                        ))
                                  ]))));
                    }),
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E0657), //(0xFF0E0657),
                      border: Border.all(
                        color: Colors.white, //const Color(0xFF5046E4),
                        width: 4,
                      ),

                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(children: [
                      selectedLevel == -1
                          ? AnimatedTextKit(
                              totalRepeatCount: 1,
                              animatedTexts: [
                                  TyperAnimatedTextCustom([
                                    const TextSpan(
                                      text: 'What\'s your ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'Eina',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: 'py',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 24,
                                        fontFamily: 'Eina',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: 'thon\n',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'Eina',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: 'comfort level?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'Eina',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ])
                                ])
                          : Text.rich(
                              TextSpan(
                                text: 'What\'s your ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: 'Eina',
                                  fontWeight: FontWeight.bold,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'py',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 24,
                                      fontFamily: 'Eina',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'thon\n',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'Eina',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: 'comfort level?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'Eina',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' $selectedLevel',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'Eina',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ]))
              ])
            ])),
        Expanded(
          // Takes up all remaining space
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                    height: 500,
                    width: 500,
                    child: RiveAnimation.asset(
                        "assets/images/graphics/5-level-py.riv",
                        fit: BoxFit.contain,
                        onInit: _onRiveInit,
                        stateMachines: const ["game"])),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                      //color: Colors.red,
                      padding: const EdgeInsets.all(10),
                      child: Center(
                          child: Stack(
                        children: [
                          for (int i = 0; i < breakpoints; i++)
                            Positioned(
                                top: 50 + 5,
                                left: (i *
                                    segmentWidth), // Centering the box in the segment
                                child: GestureDetector(
                                  onTap: () {
                                    levelInput?.value = i.toDouble();

                                    setState(() {
                                      selectedLevel = i;

                                      posX = (i * segmentWidth)
                                          .clamp(0, maxWidth - 50);
                                    });
                                    widget.selectLevel(i);
                                  },
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            //color: Colors.red,
                                            width: 50,
                                            height: 20,
                                            child: Center(
                                                child: Text(i.toString(),
                                                    style: TextStyle(
                                                      color: selectedLevel == i
                                                          ? Color(0xFFA2FF66)
                                                          : Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: 'Eina',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ))))
                                        // Container(
                                        //     decoration: BoxDecoration(
                                        //       border: Border.all(
                                        //         color: const Color(
                                        //             0xFF2AFF32),
                                        //         width: 4,
                                        //       ),
                                        //       borderRadius:
                                        //           BorderRadius
                                        //               .circular(100),
                                        //     ),
                                        //     width: 50,
                                        //     height: 50),
                                        // Container(
                                        //   margin:
                                        //       const EdgeInsets.only(left: 60),
                                        //   height: 100,
                                        //   width: 50,
                                        //   decoration: BoxDecoration(
                                        //     color: selectedLevel == i
                                        //         ? const Color(0xFF69EC15)
                                        //         : Color(0xFF0A062F),
                                        //     border: Border.all(
                                        //       color: selectedLevel == i
                                        //           ? const Color(0xFF2AFF32)
                                        //           : const Color(0xFF23197D),
                                        //       width: 4,
                                        //     ),
                                        //     borderRadius:
                                        //         BorderRadius.circular(10),
                                        //   ),
                                        //   child: Center(
                                        //       child: Text(levels[i],
                                        //           style: TextStyle(
                                        //             color: selectedLevel == i
                                        //                 ? Color(0xFF0A062F)
                                        //                 : Colors.white,
                                        //             fontSize: 18,
                                        //             fontFamily: 'Eina',
                                        //             fontWeight: FontWeight.bold,
                                        //           ))),
                                        // )
                                      ]),
                                )),
                          Positioned(
                              left: 20,
                              top: 20,
                              child: Container(
                                color: Colors.white,
                                height: 10,
                                width: maxWidth - 50 - 20,
                              )),
                          for (int i = 0; i < breakpoints; i++)
                            Positioned(
                                //left: (i == 0 || i == 4) ? 0 : 5,
                                top: (i == 0 || i == 4) ? 0 : 5,
                                left: (i * segmentWidth) + 20,
                                child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: (i == 0 || i == 4) ? 50 : 40,
                                    //width: (i == 0 || i == 4) ? 50 : 40,
                                    width: 10)),
                          Positioned(
                            left: posX,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                setState(() {
                                  posX += details.delta.dx;
                                  print(posX);
                                  isDragging = true;

                                  // Prevent the thumb from moving outside the slider
                                  if (posX < 0) posX = 0;
                                  if (posX >
                                      (4 * segmentWidth)
                                          .clamp(0, maxWidth - 50)) {
                                    posX = (4 * segmentWidth)
                                        .clamp(0, maxWidth - 50);
                                    // 50 is the thumb height
                                  }
                                });
                              },
                              onPanEnd: (details) {
                                // Snap to the nearest breakpoint after releasing
                                final nearestBreakpoint = ((posX + 25) /
                                        segmentWidth)
                                    .round(); // Adding 25 to center the snap position

                                setState(() {
                                  selectedLevel = nearestBreakpoint;
                                  widget.selectLevel(nearestBreakpoint);
                                  levelInput?.value =
                                      nearestBreakpoint.toDouble();
                                  isDragging = false;
                                  posX = (nearestBreakpoint * segmentWidth).clamp(
                                      0,
                                      maxWidth -
                                          50); // Clamp to ensure it doesn't exceed bounds
                                });
                              },
                              child: Container(
                                width: 50.0, // Width of the draggable thumb
                                height: 50.0, // Height of the draggable thumb

                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFF2AFF32),
                                    width: 4,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),

                                alignment: Alignment.center,
                                child: Stack(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF69EC15),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    width: 25,
                                    height: 25,
                                  ),
                                ]),
                              ),
                            ),
                          ),
                          isDragging
                              ? Positioned(
                                  top: 5,
                                  left: posX + 5,
                                  child: GestureDetector(
                                    onPanUpdate: (details) {
                                      setState(() {
                                        posX += details.delta.dx;

                                        // Prevent the thumb from moving outside the slider
                                        if (posX < 0) posX = 0;
                                        if (posX >
                                            (4 * segmentWidth)
                                                .clamp(0, maxWidth - 50)) {
                                          posX = (4 * segmentWidth)
                                              .clamp(0, maxWidth - 50);
                                          // 50 is the thumb height
                                        }
                                      });
                                    },
                                    onPanEnd: (details) {
                                      // Snap to the nearest breakpoint after releasing
                                      final nearestBreakpoint = ((posX + 25) /
                                              segmentWidth)
                                          .round(); // Adding 25 to center the snap position

                                      setState(() {
                                        selectedLevel = nearestBreakpoint;
                                        levelInput?.value =
                                            nearestBreakpoint.toDouble();
                                        posX = (nearestBreakpoint *
                                                segmentWidth)
                                            .clamp(
                                                0,
                                                maxWidth -
                                                    50); // Clamp to ensure it doesn't exceed bounds
                                      });
                                    },
                                    child: const SizedBox(
                                      width:
                                          90.0, // Width of the draggable thumb
                                      height:
                                          90.0, // Height of the draggable thumb
                                      child: RiveAnimation.asset(
                                        "assets/images/graphics/mouse.riv",
                                        fit: BoxFit.contain,
                                        stateMachines: ["game"],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      )))),
            ],
          ),
        ),
      ],
    );
  }
}

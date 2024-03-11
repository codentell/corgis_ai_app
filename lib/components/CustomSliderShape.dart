import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:corgis_ai_app/components/TyperAnimatedTextCustom.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'dart:math';

import 'package:simple_animations/animation_builder/custom_animation_builder.dart';

class CustomSliderWithRiveThumb extends StatefulWidget {
  const CustomSliderWithRiveThumb({Key? key}) : super(key: key);

  @override
  _CustomSliderWithRiveThumbState createState() =>
      _CustomSliderWithRiveThumbState();
}

class _CustomSliderWithRiveThumbState extends State<CustomSliderWithRiveThumb> {
  double posY = 0.0;
  final int breakpoints = 5;
  late int selectedLevel;
  SMIInput<double>? levelInput;

  late double maxHeight = 425;
  late double segmentHeight = maxHeight / (breakpoints);

  double deg2rad(double deg) => deg * pi / 180;

  initState() {
    setState(() {
      selectedLevel = -1;
      posY = (2 * segmentHeight).clamp(0, maxHeight - 50);
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
    List<String> levels = [
      "level 0",
      "level 1",
      "level 2",
      "level 3",
      "level 4"
    ];
    //maxHeight -= segmentHeight; // Subtract the thumb height

    // return Container(
    //   padding: const EdgeInsets.all(10),
    //   color: Colors.orange,
    //   height: 50,
    //   width: 50, // Fixed width for the vertical slider
    //   child:

    return Column(
      children: [
        Container(
            height: 120,
            margin: const EdgeInsets.all(10),
            //color: Colors.yellow,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                      height: 80,
                      width: 80,
                      child: RiveAnimation.network(
                          "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/kody.riv",
                          fit: BoxFit.cover,
                          animations: ["idle"])),
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
                                        text: ' level?',
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
                                    TextSpan(
                                      text: ' level?',
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
                ])),
        Expanded(
          // Takes up all remaining space
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      //color: Colors.red,
                      padding: const EdgeInsets.all(10),
                      child: Center(
                          child: Container(
                              //color: Colors.green,
                              child: Stack(
                        children: [
                          for (int i = 0; i < breakpoints; i++)
                            Positioned(
                                top: (i *
                                    segmentHeight), // Centering the box in the segment
                                child: GestureDetector(
                                  onTap: () {
                                    levelInput?.value = i.toDouble();
                                    setState(() {
                                      selectedLevel = i;
                                      posY = (i * segmentHeight)
                                          .clamp(0, maxHeight - 50);
                                    });
                                  },
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 60),
                                          height: 50,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: selectedLevel == i
                                                ? const Color(0xFF69EC15)
                                                : Color(0xFF0A062F),
                                            border: Border.all(
                                              color: selectedLevel == i
                                                  ? const Color(0xFF2AFF32)
                                                  : const Color(0xFF23197D),
                                              width: 4,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                              child: Text(levels[i],
                                                  style: TextStyle(
                                                    color: selectedLevel == i
                                                        ? Color(0xFF0A062F)
                                                        : Colors.white,
                                                    fontSize: 18,
                                                    fontFamily: 'Eina',
                                                    fontWeight: FontWeight.bold,
                                                  ))),
                                        )
                                      ]),
                                )),
                          Positioned(
                              left: 20,
                              top: 20,
                              child: Container(
                                color: Colors.white,
                                height: (4 * segmentHeight),
                                width: 10,
                              )),
                          for (int i = 0; i < breakpoints; i++)
                            Positioned(
                                left: (i == 0 || i == 4) ? 0 : 5,
                                top: (i * segmentHeight) + 20,
                                child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: (i == 0 || i == 4) ? 50 : 40,
                                    height: 10)),
                          Positioned(
                            top: posY,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                setState(() {
                                  posY += details.delta.dy;
                                  print(posY);

                                  // Prevent the thumb from moving outside the slider
                                  if (posY < 0) posY = 0;
                                  if (posY >
                                      (4 * segmentHeight)
                                          .clamp(0, maxHeight - 50)) {
                                    posY = (4 * segmentHeight)
                                        .clamp(0, maxHeight - 50);
                                    // 50 is the thumb height
                                  }
                                });
                              },
                              onPanEnd: (details) {
                                // Snap to the nearest breakpoint after releasing
                                final nearestBreakpoint = ((posY + 25) /
                                        segmentHeight)
                                    .round(); // Adding 25 to center the snap position

                                setState(() {
                                  selectedLevel = nearestBreakpoint;
                                  levelInput?.value =
                                      nearestBreakpoint.toDouble();
                                  posY = (nearestBreakpoint * segmentHeight).clamp(
                                      0,
                                      maxHeight -
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
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF69EC15),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))))),
              Expanded(
                flex: 1,
                child: Container(
                    height: 500,
                    child: RiveAnimation.asset(
                        "assets/images/graphics/5-level-py.riv",
                        fit: BoxFit.contain,
                        onInit: _onRiveInit,
                        stateMachines: ["game"])),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

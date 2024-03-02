import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:rive/rive.dart';

class HelloPage extends StatefulWidget {
  const HelloPage({super.key});

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<HelloPage> {
  SMIInput<bool>? isContinue;
  bool disabled = false;

  void onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'game');
    artboard.addController(controller!);
    isContinue = controller.findInput<bool>('continue') as SMIBool;
    //print(isContinue?.value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF0A062F),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            backgroundColor: Color(0xFF0A062F),
            body: Center(
                child: Container(
              width: 350,
              height: 350,
              child: RiveAnimation.network(
                'https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/welcome.riv',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                stateMachines: ["game"],
                onInit: onRiveInit,
              ),
            )),
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
                                Future.delayed(
                                    const Duration(milliseconds: 1000), () {
                                  setState(() {
                                    disabled = !disabled;
                                  });
                                  isContinue?.value = true;
                                });

                                setState(() {
                                  disabled = !disabled;
                                });

                                if (isContinue?.value == true) {
                                  Navigator.of(context).pushNamed('/welcome/1');
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
                                                      ? Colors.grey
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
                                                            ? Colors.grey
                                                            : Color(0xFFB9FF8C),
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
                                                        color: disabled
                                                            ? Colors.grey
                                                            : Color(0xFFB9FF8C),
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
                                                    ? Color(0xFF676767)
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
                                                  ? Color(0xFF676767)
                                                  : const Color(0xFF69EC15),
                                            ),
                                          ),
                                        ]));
                                  }))),
                    ])))));
  }
}

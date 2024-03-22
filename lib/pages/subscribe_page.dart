import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({super.key});

  @override
  SubscribePageState createState() => SubscribePageState();
}

class SubscribePageState extends State<SubscribePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                      ),
                      const Expanded(
                          flex: 5,
                          child: SizedBox(
                            width: 200,
                            height: 20,
                          )),
                      Container(
                          width: 100,
                          height: 100,
                          color: const Color(0xFF0A062F),
                          child: IconButton(
                              icon: const Icon(Icons.close,
                                  size: 50, color: Colors.white),
                              onPressed: () => {Navigator.pop(context, true)})),
                    ],
                  ),
                )),
            body: Container(
                color: const Color(0xFF0A062F),
                child: Center(
                    child: Container(
                        margin: const EdgeInsets.only(
                            top: 20, right: 20, left: 20, bottom: 20),
                        height: 300,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "Progress faster in your python\ncourse with Super corgis.ai",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Eina',
                                      fontWeight: FontWeight.bold)),
                              Container(height: 20),
                              Expanded(
                                  child: Container(
                                      height: 10,
                                      child: Row(children: [
                                        Expanded(flex: 2, child: Container()),
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                                child: Text("Free",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold)))),
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                                child: Text("Super",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontFamily: 'Eina',
                                                        fontWeight:
                                                            FontWeight.bold))))
                                      ]))),
                              Expanded(
                                  child: Container(
                                      height: 10,
                                      padding: EdgeInsets.all(5),
                                      child: Row(children: [
                                        Expanded(
                                            flex: 2,
                                            child: Text("Level content",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: 'Eina',
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Expanded(
                                            flex: 1,
                                            child: Icon(Icons.check,
                                                color: Colors.white)),
                                        Expanded(
                                            flex: 1,
                                            child: Icon(Icons.check,
                                                color: Colors.white))
                                      ]))),
                              Expanded(
                                  child: Container(
                                      height: 10,
                                      padding: EdgeInsets.all(5),
                                      color: Colors.green,
                                      child: Row(children: [
                                        Expanded(
                                            flex: 2,
                                            child: Text("Unlimited Hearts",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: 'Eina',
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Expanded(flex: 1, child: Container()),
                                        Expanded(
                                            flex: 1,
                                            child: Icon(Icons.check,
                                                color: Colors.white))
                                      ]))),
                              Expanded(
                                  child: Container(
                                      height: 10,
                                      padding: EdgeInsets.all(5),
                                      color: Colors.green,
                                      child: Row(children: [
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                                "AI Personalized learning",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: 'Eina',
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Expanded(flex: 1, child: Container()),
                                        Expanded(
                                            flex: 1,
                                            child: Icon(Icons.check,
                                                color: Colors.white))
                                      ]))),
                              Expanded(
                                  child: Container(
                                      height: 10,
                                      padding: EdgeInsets.all(5),
                                      color: Colors.green,
                                      child: Row(children: [
                                        Expanded(
                                            flex: 2,
                                            child: Text("Interview prep",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: 'Eina',
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Expanded(flex: 1, child: Container()),
                                        Expanded(
                                            flex: 1,
                                            child: Icon(Icons.check,
                                                color: Colors.white))
                                      ]))),
                              Expanded(
                                  child: Container(
                                      height: 10,
                                      padding: EdgeInsets.all(5),
                                      color: Colors.green,
                                      child: Row(children: [
                                        Expanded(
                                            flex: 2,
                                            child: Text("No ads",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: 'Eina',
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Expanded(flex: 1, child: Container()),
                                        Expanded(
                                            flex: 1,
                                            child: Icon(Icons.check,
                                                color: Colors.white))
                                      ]))),
                              Expanded(
                                  child: Container(
                                      height: 10,
                                      padding: EdgeInsets.all(5),
                                      color: Colors.green,
                                      child: Row(children: [
                                        Expanded(
                                            flex: 2,
                                            child: Text("No ads",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: 'Eina',
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Expanded(flex: 1, child: Container()),
                                        Expanded(
                                            flex: 1,
                                            child: Icon(Icons.check,
                                                color: Colors.white))
                                      ]))),
                            ])))),
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
                              onTap: () {},
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
                                                        color: const Color(
                                                            0xFFB9FF8C),
                                                      ),
                                                    ),
                                                    const Center(
                                                        child: Row(
                                                      children: [
                                                        Text("continue",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF1a1e4c),
                                                              fontSize: 21,
                                                              fontFamily:
                                                                  'Eina',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ))
                                                      ],
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

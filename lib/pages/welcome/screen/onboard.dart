import 'package:corgis_ai_app/components/progress.dart';
import 'package:corgis_ai_app/pages/welcome/screen/language.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:corgis_ai_app/constants/index.dart';
import 'package:corgis_ai_app/pages/welcome/screen/goal.dart';
import 'package:corgis_ai_app/components/CustomSliderShape.dart';

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
  late String goal;
  late String referral;
  late List<Map> languages;
  late List<Map> goals;
  late double currentSliderValue;

  @override
  void initState() {
    setState(() {
      disabled = true;
      progress = 0;
      page = 0;
      language = "";
      referral = "";
      goal = "";
      currentSliderValue = 0;
      goals = goalList;
      languages = languageList;
    });
    super.initState();
  }

  void selectLanguage(int i) {
    setState(() {
      disabled = false;
      language = languages[i]["language"]!;
    });
    print(language);
  }

  void selectGoal(int i) {
    setState(() {
      disabled = false;
      goal = goals[i]["text"]!;
    });
    print(goal);
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
                                          disabled = false;
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
                  GoalPage(
                    goal: goal,
                    disabled: disabled,
                    goals: goals,
                    selectGoal: selectGoal,
                  ),
                  LanguagePage(
                    disabled: disabled,
                    languages: languages,
                    language: language,
                    selectLanguage: selectLanguage,
                  ),
                  // ReferralPage(
                  //   disabled: disabled,
                  //   referral: referral,
                  // ),
                  Container(
                      color: Colors.blue,
                      child: CustomSliderWithRiveThumb(),
                      height: 100),
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
                                                      const BorderRadius.only(
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

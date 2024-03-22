import 'package:corgis_ai_app/components/progress.dart';
import 'package:corgis_ai_app/pages/welcome/screen/achievement.dart';
import 'package:corgis_ai_app/pages/welcome/screen/daily_notification.dart';
import 'package:corgis_ai_app/pages/welcome/screen/discovery.dart';
import 'package:corgis_ai_app/pages/welcome/screen/language.dart';
import 'package:corgis_ai_app/pages/welcome/screen/level.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:corgis_ai_app/constants/index.dart';
import 'package:corgis_ai_app/pages/welcome/screen/goal.dart';
import 'package:corgis_ai_app/pages/welcome/screen/quest.dart';

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
  late String dailyNotification;
  late String achievement;
  late String referral;
  late String discovery;
  late List<Map> languages;
  late List<Map> goals;
  late List<Map> dailyNotifications;
  late List<Map> quests;
  late List<Map> discoveries;
  late String quest;
  late int level;
  late double currentSliderValue;

  @override
  void initState() {
    setState(() {
      disabled = true;
      progress = 0;
      page = 0;
      level = 2;
      language = "";
      referral = "";
      goal = "";
      quest = "";
      achievement = "";
      dailyNotification = "";
      discovery = "";
      currentSliderValue = 0;
      goals = goalList;
      languages = languageList;
      quests = questsList;
      dailyNotifications = dailyNotificationList;
      discoveries = discoveryList;
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

  void selectLevel(int i) {
    setState(() {
      disabled = false;
      level = level;
    });
  }

  void selectAchievement(String achievement) {
    setState(() {
      disabled = false;
      achievement = achievement;
    });
  }

  void selectDailyNotification(int i) {
    setState(() {
      disabled = false;
      dailyNotification = dailyNotifications[i]["text"]!;
    });
  }

  void selectQuest(int i) {
    setState(() {
      disabled = false;
      quest = quests[i]["name"]!;
    });
  }

  void selectDiscovery(int i) {
    setState(() {
      disabled = false;
      discovery = discoveries[i]["discover"]!;
    });
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
                  double increment = 100 / 6;

                  if (num == 6) {
                    setState(() {
                      progress = 100;
                    });
                  } else {
                    setState(() {
                      progress = (num * increment);
                    });
                  }
                },
                children: [
                  GoalPage(
                    goal: goal,
                    disabled: disabled,
                    goals: goals,
                    selectGoal: selectGoal,
                  ),
                  AchievementPage(
                    disabled: disabled,
                    goal: goal,
                    selectAchievement: selectAchievement,
                  ),
                  LanguagePage(
                    disabled: disabled,
                    languages: languages,
                    language: language,
                    selectLanguage: selectLanguage,
                  ),
                  LevelPage(
                      selectLevel: selectLevel,
                      disabled: disabled,
                      level: level),
                  DailyNotificationPage(
                      disabled: disabled,
                      dailyNotification: dailyNotification,
                      dailyNotifications: dailyNotifications,
                      selectDailyNotification: selectDailyNotification),
                  QuestPage(
                    disabled: disabled,
                    quests: quests,
                    quest: quest,
                    language: language,
                    selectQuest: selectQuest,
                  ),
                  DiscoveryPage(
                    disabled: disabled,
                    discoveries: discoveries,
                    discovery: discovery,
                    selectDiscovery: selectDiscovery,
                  )
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
                                if (progress == 100) {
                                  Navigator.pushReplacementNamed(
                                      context, '/subscribe');
                                }
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
                                                      : const Color(0xFFA2FF66),
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
                                                        child: Row(
                                                      children: [
                                                        disabled
                                                            ? Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            10),
                                                                height: 30,
                                                                width: 30,
                                                                child:
                                                                    const RiveAnimation
                                                                        .asset(
                                                                  'assets/images/icons/lock.riv',
                                                                  animations: [
                                                                    'idle'
                                                                  ],
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ))
                                                            : Container(),
                                                        Text("continue",
                                                            style: TextStyle(
                                                              color: disabled
                                                                  ? const Color(
                                                                      0xFF49C1F9)
                                                                  : const Color(
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

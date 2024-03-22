import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:corgis_ai_app/main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:corgis_ai_app/components/TyperAnimatedTextCustom.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:rive/rive.dart';

class ReminderPage extends StatefulWidget {
  final bool disabled;
  const ReminderPage({super.key, required this.disabled});

  @override
  ReminderPageState createState() => ReminderPageState();
}

class ReminderPageState extends State<ReminderPage> {
  Future<void> setupReminder(String fcmToken) async {
    // var uuid = const Uuid();
    // String userId = uuid.v4();
    // print(fcmToken);
    // print('UUID: $userId');

    final userId = supabase.auth.currentUser?.id;
    print('User ID: $userId');

    await supabase.from('profiles').upsert({
      'id': userId,
      'fcm_token': fcmToken,
    });
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
                                    color:
                                        Colors.white, //const Color(0xFF5046E4),
                                    width: 4,
                                  ),
                                  //color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(children: [
                                  Expanded(
                                      child: AnimatedTextKit(
                                          totalRepeatCount: 1,
                                          animatedTexts: [
                                        TyperAnimatedTextCustom([
                                          const TextSpan(
                                            text:
                                                'I\'ll remind you to practice so it becomes a habit!',
                                            style: TextStyle(
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
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFFE5E5E5), //const Color(0xFF5046E4),
                            width: 4,
                          ),
                          color: Color(0xFFF7F7F7),
                        ),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(children: [
                          Expanded(
                              flex: 2,
                              child: Container(
                                child: Center(
                                    child: Center(
                                        child: Text(
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFFADADAD),
                                              fontSize: 18,
                                              fontFamily: 'Eina',
                                              fontWeight: FontWeight.bold,
                                            ),
                                            "\"corgis.ai\" would like to send you Notifications"))),
                              )),
                          Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xFFE5E5E5),
                                    width: 4,
                                  ),
                                ),
                              ),
                              child: Row(children: [
                                Expanded(
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                              color: Color(0xFFE5E5E5),
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                            child: Text("Not Allow",
                                                style: TextStyle(
                                                  color: Color(0xFFADADAD),
                                                  fontSize: 18,
                                                  fontFamily: 'Eina',
                                                  fontWeight: FontWeight.bold,
                                                ))))),
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () async {
                                          await FirebaseMessaging.instance
                                              .requestPermission();
                                          await FirebaseMessaging.instance
                                              .getAPNSToken();
                                          final fcmToken =
                                              await FirebaseMessaging.instance
                                                  .getToken();
                                          print('FCM Token: $fcmToken');
                                          if (fcmToken != null) {
                                            await setupReminder(fcmToken);
                                          }
                                        },
                                        child: Center(
                                            child: Text("Allow",
                                                style: TextStyle(
                                                  color: Color(0xFF52ADF1),
                                                  fontSize: 18,
                                                  fontFamily: 'Eina',
                                                  fontWeight: FontWeight.bold,
                                                ))))),
                              ]))
                        ]),
                        height: 200),
                  ])),
            ])));
  }
}

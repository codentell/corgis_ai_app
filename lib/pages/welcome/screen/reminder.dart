import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:corgis_ai_app/main.dart';
import 'package:uuid/uuid.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  ReminderPageState createState() => ReminderPageState();
}

class ReminderPageState extends State<ReminderPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> setupReminder(String fcmToken) async {
    var uuid = const Uuid();
    String userId = uuid.v4();
    print(fcmToken);
    print('UUID: $userId');

    await supabase.from('profiles').upsert({
      'id': userId,
      'fcm_token': fcmToken,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.green,
      child: GestureDetector(
          onTap: () async {
            await FirebaseMessaging.instance.requestPermission();
            await FirebaseMessaging.instance.getAPNSToken();
            final fcmToken = await FirebaseMessaging.instance.getToken();
            if (fcmToken != null) {
              await setupReminder(fcmToken);
            }
          },
          child: Center(child: Text("Allow Reminder Page"))),
    ));
  }
}

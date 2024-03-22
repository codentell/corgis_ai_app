import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  TestPageState createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return (Container(
        color: Colors.blue,
        child: GestureDetector(
            onTap: () async {
              //FirebaseMessaging.getInstance().deleteToken();
              Supabase.instance.client.auth.signOut();
              Navigator.pushNamed(context, "/start");
            },
            child: Text("Logout"))));
  }
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    //ProfilePage(),
    TestPage(),
    Container(color: Colors.green),
    Container(color: Colors.yellow),
    //StoryPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xFF0A062F),
            body: IndexedStack(
              index: selectedIndex,
              children: pages,
            ),
            bottomNavigationBar: BottomAppBar(
              color: Color(0xFF0A062F),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(12),
                  //     border: selectedIndex == 0
                  //         ? Border(
                  //             top: BorderSide(
                  //                 width: 2.0, color: Color(0xFF42FF00)),
                  //             bottom: BorderSide(
                  //                 width: 2.0, color: Color(0xFF42FF00)),
                  //             left: BorderSide(
                  //                 width: 2.0, color: Color(0xFF42FF00)),
                  //             right: BorderSide(
                  //                 width: 2.0, color: Color(0xFF42FF00)),
                  //           )
                  //         : null,
                  //   ),
                  //   child: IconButton(
                  //     icon: Icon(Icons.home, color: Colors.white),
                  //     onPressed: () => {onItemTapped(0)},
                  //   ),
                  //   width: 70,
                  //   height: 70,
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(12),
                  //     //color: Colors.red,
                  //     border: selectedIndex == 1
                  //         ? Border(
                  //             top: BorderSide(
                  //                 width: 2.0, color: Color(0xFF42FF00)),
                  //             bottom: BorderSide(
                  //                 width: 2.0, color: Color(0xFF42FF00)),
                  //             left: BorderSide(
                  //                 width: 2.0, color: Color(0xFF42FF00)),
                  //             right: BorderSide(
                  //                 width: 2.0, color: Color(0xFF42FF00)),
                  //           )
                  //         : null,
                  //   ),
                  //   child: IconButton(
                  //     icon: Icon(Icons.home, color: Colors.white),
                  //     onPressed: () => {
                  //       onItemTapped(1),
                  //     },
                  //   ),
                  //   width: 70,
                  //   height: 70,
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(12),
                  //     //color: Colors.red,
                  //     border: selectedIndex == 2
                  //         ? Border(
                  //             top: BorderSide(
                  //                 width: 2.0, color: Color(0xFF42FF00)),
                  //             bottom: BorderSide(
                  //                 width: 2.0, color: Color(0xFF42FF00)),
                  //             left: BorderSide(
                  //                 width: 2.0, color: Color(0xFF42FF00)),
                  //             right: BorderSide(
                  //                 width: 2.0, color: Color(0xFF42FF00)),
                  //           )
                  //         : null,
                  //   ),
                  //   child: IconButton(
                  //     icon: Icon(Icons.home, color: Colors.white),
                  //     onPressed: () => {
                  //       onItemTapped(2),
                  //     },
                  //   ),
                  //   width: 70,
                  //   height: 70,
                  // ),
                  GestureDetector(
                      onTap: () {
                        onItemTapped(3);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: selectedIndex == 3
                              ? Color(0xFFBDFF9C).withOpacity(0.85)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          //color: Colors.red,
                          border: selectedIndex == 3
                              ? Border(
                                  top: BorderSide(
                                      width: 2.0, color: Color(0xFF42FF00)),
                                  bottom: BorderSide(
                                      width: 2.0, color: Color(0xFF42FF00)),
                                  left: BorderSide(
                                      width: 2.0, color: Color(0xFF42FF00)),
                                  right: BorderSide(
                                      width: 2.0, color: Color(0xFF42FF00)),
                                )
                              : Border(
                                  top: BorderSide(
                                      width: 2.0, color: Colors.transparent),
                                  bottom: BorderSide(
                                      width: 2.0, color: Colors.transparent),
                                  left: BorderSide(
                                      width: 2.0, color: Colors.transparent),
                                  right: BorderSide(
                                      width: 2.0, color: Colors.transparent),
                                ),
                        ),
                        child: Container(
                            child: RiveAnimation.network(
                                "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/explore.riv",
                                fit: BoxFit.contain,
                                animations: ["idle"])),
                        width: 70,
                        height: 70,
                      )),
                  GestureDetector(
                      onTap: () {
                        onItemTapped(4);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: selectedIndex == 4
                              ? Color(0xFFBDFF9C).withOpacity(0.85)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          //color: Colors.red,
                          border: selectedIndex == 4
                              ? Border(
                                  top: BorderSide(
                                      width: 2.0, color: Color(0xFF42FF00)),
                                  bottom: BorderSide(
                                      width: 2.0, color: Color(0xFF42FF00)),
                                  left: BorderSide(
                                      width: 2.0, color: Color(0xFF42FF00)),
                                  right: BorderSide(
                                      width: 2.0, color: Color(0xFF42FF00)),
                                )
                              : Border(
                                  top: BorderSide(
                                      width: 2.0, color: Colors.transparent),
                                  bottom: BorderSide(
                                      width: 2.0, color: Colors.transparent),
                                  left: BorderSide(
                                      width: 2.0, color: Colors.transparent),
                                  right: BorderSide(
                                      width: 2.0, color: Colors.transparent),
                                ),
                        ),
                        child: Container(
                            child: RiveAnimation.network(
                                "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/book.riv",
                                fit: BoxFit.contain,
                                animations: ["idle"])),
                        width: 70,
                        height: 70,
                      )),
                ],
              ),
            )));
  }
}

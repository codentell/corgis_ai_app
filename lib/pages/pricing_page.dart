import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:corgis_ai_app/constants/revenue_cat.dart';

import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class Paywall extends StatefulWidget {
  final Offering offering;

  const Paywall({Key? key, required this.offering}) : super(key: key);

  @override
  _PaywallState createState() => _PaywallState();
}

class _PaywallState extends State<Paywall> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Wrap(
          children: <Widget>[
            Container(
              height: 70.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0))),
              child: const Center(child: Text('✨ Corgis Weather Premium')),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: SizedBox(
                child: Text(
                  'MAGIC WEATHER PREMIUM',
                ),
                width: double.infinity,
              ),
            ),
            ListView.builder(
              itemCount: widget.offering.availablePackages.length,
              itemBuilder: (BuildContext context, int index) {
                var myProductList = widget.offering.availablePackages;
                return Card(
                    color: Colors.white,
                    child: ListTile(
                        onTap: () async {
                          try {
                            CustomerInfo customerInfo =
                                await Purchases.purchasePackage(
                                    myProductList[index]);
                            EntitlementInfo? entitlement =
                                customerInfo.entitlements.all[entitlementID];
                            if (entitlement?.isActive == true) {
                              Navigator.pushReplacementNamed(context, '/home');
                            }

                            // appData.entitlementIsActive =
                            //     entitlement?.isActive ?? false;
                          } catch (e) {
                            print(e);
                          }

                          setState(() {});
                          Navigator.pop(context);
                        },
                        title: Text(
                          myProductList[index].storeProduct.title,
                        ),
                        subtitle: Text(
                          myProductList[index].storeProduct.description,
                        ),
                        trailing: Text(
                            myProductList[index].storeProduct.priceString)));
              },
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: SizedBox(
                child: Text(
                  footerText,
                ),
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowDialogToDismiss extends StatelessWidget {
  final String content;
  final String title;
  final String buttonText;

  const ShowDialogToDismiss(
      {Key? key,
      required this.title,
      required this.buttonText,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return AlertDialog(
        title: Text(
          title,
        ),
        content: Text(
          content,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              buttonText,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
      return CupertinoAlertDialog(
          title: Text(
            title,
          ),
          content: Text(
            content,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                buttonText[0].toUpperCase() +
                    buttonText.substring(1).toLowerCase(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]);
    }
  }
}

class PricingPage extends StatefulWidget {
  const PricingPage({super.key});

  @override
  PricingPageState createState() => PricingPageState();
}

class PricingPageState extends State<PricingPage> {
  @override
  void initState() {
    super.initState();
  }

  void test() async {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    print(customerInfo);
    if (customerInfo.entitlements.all[entitlementID] != null &&
        customerInfo.entitlements.all[entitlementID]?.isActive == true) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Offerings? offerings;
      try {
        offerings = await Purchases.getOfferings();
        print(offerings);
      } on PlatformException catch (e) {
        await showDialog(
            context: context,
            builder: (BuildContext context) => ShowDialogToDismiss(
                title: "Error",
                content: e.message ?? "Unknown error",
                buttonText: 'OK'));
      }
      if (offerings == null || offerings.current == null) {
        // offerings are empty, show a message to your user
      } else {
        // current offering is available, show paywall
        await showModalBottomSheet(
          useRootNavigator: true,
          isDismissible: true,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
              return Paywall(
                offering: offerings!.current!,
              );
            });
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF0A062F),
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
      body: SingleChildScrollView(
          child: Container(
              color: const Color(0xFF0A062F),
              child: Center(
                  child: Container(
                      margin: const EdgeInsets.only(
                          top: 20, right: 20, left: 20, bottom: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Choose your plan for after\n your free trial",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Eina',
                                    fontWeight: FontWeight.bold)),
                            Container(height: 20),
                            Container(height: 300, color: Colors.white),
                            Container(height: 10),
                            Center(
                                child: Text("cancel anytime in the App Store",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Eina',
                                    ))),
                            Container(height: 10),
                            GestureDetector(
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
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Center(
                                                          child: Row(
                                                        children: [
                                                          Text(
                                                              "start my free 7 days",
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
                                                  color:
                                                      const Color(0xFF69EC15),
                                                  width: 3,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                ),
                                                color: const Color(0xFF69EC15),
                                              ),
                                            ),
                                          ]));
                                    })),
                            Container(height: 15),
                            GestureDetector(
                                onTap: () => test(),
                                child: Center(
                                    child: Text("view all plans",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 21,
                                            fontFamily: 'Eina',
                                            fontWeight: FontWeight.bold)))),
                            Container(height: 30),
                            Container(
                                child: Center(
                                    child: Text(
                                        "Your monthly or annual subscription automatically renews for the same term unless cancelled at least 24 hours prior to the end of the current term. Cancel any time in the App Store at no additional cost; your subscription will then cease at the end of the current term.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Eina',
                                        ))))
                          ]))))),
    ));
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:corgis_ai_app/main.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  //final _email = TextEditingController();
  @override
  void initState() {
    setupAuthListener();
    super.initState();
  }

  void setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Navigator.of(context).pushNamed('/home');
      }
    });
  }

  Future<AuthResponse> _googleSignIn() async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '994572789648-u45a7dg4lija8o3q4dr52k6lufhrfrkg.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId =
        '994572789648-2htlj9q9h7h8j81164klf3ddstquvcur.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('isLogin', true);

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF0A062F),
      // appBar: PreferredSize(
      //     preferredSize: const Size.fromHeight(70),
      //     child: Container(
      //         height: 70,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Container(
      //                 width: 100,
      //                 height: 50,
      //                 color: const Color(0xFF1B282E),
      //                 child: IconButton(
      //                     icon:
      //                         const Icon(Icons.arrow_back, color: Colors.white),
      //                     onPressed: () => {Navigator.pop(context, true)})),
      //             Expanded(
      //               flex: 5,
      //               child: Center(
      //                 child: Text(
      //                   '',
      //                   style: TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 24,
      //                     fontFamily: 'Eina',
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             Container(
      //               width: 100,
      //               height: 50,
      //               color: const Color(0xFF1B282E),
      //             ),
      //           ],
      //         ),
      //         decoration: BoxDecoration(
      //           color: const Color(0xFF0A062F),
      //           border: Border(
      //             bottom: BorderSide(color: Color(0xFF5046E4), width: 4),
      //           ),
      //         ))),
      body: Center(
          child: Container(
              height: 1080,
              width: 500,
              child: Stack(children: [
                const RiveAnimation.network(
                  "https://s3.amazonaws.com/cdn.codewithcorgis.com/ai/interviews/login.riv",
                  fit: BoxFit.contain,
                  animations: ['idle'],
                ),
                Container(
                    margin: const EdgeInsets.only(left: 40, right: 40),
                    height: 300,
                    width: 500,
                    color: Colors.transparent,
                    child: Column(children: [
                      // Expanded(
                      //     child: Container(
                      //         height: 50,
                      //         //padding: EdgeInsets.all(10),
                      //         child: TextFormField(
                      //           cursorWidth: 3,
                      //           cursorColor: Color(0xFFC371FE),
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 18,
                      //             fontFamily: 'Eina',
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //           keyboardType: TextInputType.emailAddress,
                      //           autofillHints: const [AutofillHints.email],
                      //           validator: (value) {
                      //             // if (value == null ||
                      //             //     value.isEmpty ||
                      //             //     !EmailValidator.validate(_email.text)) {
                      //             //   return 'Please enter a valid email address';
                      //             // }
                      //             return null;
                      //           },
                      //           decoration: InputDecoration(
                      //               focusedBorder: OutlineInputBorder(
                      //                 borderRadius: BorderRadius.circular(16.0),
                      //                 borderSide: BorderSide(
                      //                   color: Color(0xFFC371FE),
                      //                   width: 2.0,
                      //                 ),
                      //               ),
                      //               enabledBorder: OutlineInputBorder(
                      //                 borderRadius: BorderRadius.circular(16.0),
                      //                 borderSide: BorderSide(
                      //                   color: Color(0xFFC371FE),
                      //                   width: 2.0,
                      //                 ),
                      //               ),
                      //               border: OutlineInputBorder(
                      //                 borderRadius: BorderRadius.circular(16),
                      //               ),
                      //               hintStyle: TextStyle(
                      //                   fontSize: 18, color: Colors.white),
                      //               // fillColor: Colors.red,
                      //               // prefixIcon: Icon(Icons.email),
                      //               hintText: 'Enter a email address'),
                      //           controller: _email,
                      //         ))),
                      Center(
                          child: Container(
                        height: 50,
                        color: Colors.red,
                        child: Text("or"),
                      )),
                      Row(children: [
                        Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  _googleSignIn();
                                },
                                child: CustomAnimationBuilder<double>(
                                    // control:
                                    //     control, // bind variable with control instruction
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
                                                    : 500,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
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
                                                      Container(
                                                          width: 30,
                                                          height: 30,
                                                          child: RiveAnimation
                                                              .asset(
                                                            'assets/images/icons/google.riv',
                                                            animations: const [
                                                              'idle'
                                                            ],
                                                            fit: BoxFit.contain,
                                                          )),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 5),
                                                        child: Text(
                                                          "Google",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF1a1e4c),
                                                            fontSize: 21,
                                                            fontFamily: 'Eina',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      )
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
                                                  color: Color.fromARGB(
                                                      255, 235, 235, 235),
                                                  width: 3,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                ),
                                                color: Color.fromARGB(
                                                    255, 235, 235, 235),
                                              ),
                                            ),
                                          ]));
                                    }))),
                        Container(
                          width: 10,
                        ),
                        Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  _googleSignIn();
                                },
                                child: CustomAnimationBuilder<double>(
                                    // control:
                                    //     control, // bind variable with control instruction
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
                                                    : 500,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
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
                                                      Container(
                                                          width: 30,
                                                          height: 30,
                                                          child: RiveAnimation
                                                              .asset(
                                                            'assets/images/icons/apple.riv',
                                                            animations: const [
                                                              'idle'
                                                            ],
                                                            fit: BoxFit.contain,
                                                          )),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 5),
                                                        child: Text(
                                                          "Apple",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF1a1e4c),
                                                            fontSize: 21,
                                                            fontFamily: 'Eina',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      )
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
                                                  color: const Color.fromARGB(
                                                      255, 235, 235, 235),
                                                  width: 3,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                ),
                                                color: const Color.fromARGB(
                                                    255, 235, 235, 235),
                                              ),
                                            ),
                                          ]));
                                    })))
                        // ElevatedButton(
                        //   onPressed: _googleSignIn,
                        //   child: const Text('Continue with Google'),
                        // ),
                      ]),
                      // Center(
                      //     child: Text(
                      //         "By signing in to corgis.ai, you agree to our Terms and Privacy Policy.",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 21,
                      //           fontFamily: 'Eina',
                      //           fontWeight: FontWeight.bold,
                      //         )))
                    ])),
              ]))),
      //child: Stack(children: [])
      //     child: Column(children: [
      //   Container(
      //     color: Colors.red,
      //     height: 300,
      //     child: Column(
      //       children: [
      //         Container(
      //           height: 200,
      //           color: Colors.blue,
      //         ),
      //         Container(
      //           height: 100,
      //           color: Colors.red,
      //           child: Center(
      //               child: Text(
      //             "Welcome back! Let's see if we coded together!",
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 24,
      //               fontFamily: 'Eina',
      //             ),
      //           )),
      //         ),
      //       ],
      //     ),
      //   ),
      //   ElevatedButton(
      //     onPressed: _googleSignIn,
      //     child: const Text('Google'),
      //   ),
      // ]))

      //)
    ));

    // Column(children: [
    //   Expanded(child: Container(color: Colors.red)),
    // ])

    //    Center(
    //     child: GestureDetector(
    //         onTap: _googleSignIn,
    //         child: Container(
    //           color: Colors.red,
    //           width: 400,
    //           child: const Text('Google login'),
    //         )),
    //   ),
    // )

    //);
  }
}

// import 'dart:async';

// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// // import 'package:supabase_auth_ui/src/utils/constants.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:simple_animations/simple_animations.dart';
// import 'package:rive/rive.dart';
// import 'package:url_launcher/url_launcher.dart';

// /// UI component to create magic link login form
// class LoginPage extends StatefulWidget {
//   /// `redirectUrl` to be passed to the `.signIn()` or `signUp()` methods
//   ///
//   /// Typically used to pass a DeepLink
//   final String? redirectUrl;

//   /// Method to be called when the auth action is success
//   final void Function(Session response) onSuccess;

//   /// Method to be called when the auth action threw an excepction
//   final void Function(Object error)? onError;

//   const LoginPage({
//     Key? key,
//     this.redirectUrl,
//     required this.onSuccess,
//     this.onError,
//   }) : super(key: key);

//   @override
//   State<LoginPage> createState() => LoginPageState();
// }

// class LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _email = TextEditingController();
//   late final StreamSubscription<AuthState> _gotrueSubscription;

//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _gotrueSubscription =
//         Supabase.instance.client.auth.onAuthStateChange.listen((data) {
//       final session = data.session;
//       if (session != null && mounted) {
//         widget.onSuccess(session);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _email.dispose();
//     _gotrueSubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color(0xFF0A062F),
//         appBar: AppBar(title: const Text('Login')),
//         body: SingleChildScrollView(
//             child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Container(
//               //   height: 150,
//               //   width: 150,
//               //   color: Colors.red,
//               // ),
//               Container(
//                   padding: EdgeInsets.all(20),
//                   width: 50,
//                   child: TextFormField(
//                     cursorWidth: 3,
//                     cursorColor: Color(0xFFC371FE),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontFamily: 'Eina',
//                       fontWeight: FontWeight.bold,
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                     autofillHints: const [AutofillHints.email],
//                     validator: (value) {
//                       if (value == null ||
//                           value.isEmpty ||
//                           !EmailValidator.validate(_email.text)) {
//                         return 'Please enter a valid email address';
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16.0),
//                           borderSide: BorderSide(
//                             color: Color(0xFFC371FE),
//                             width: 2.0,
//                           ),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16.0),
//                           borderSide: BorderSide(
//                             color: Color(0xFFC371FE),
//                             width: 2.0,
//                           ),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         hintStyle: TextStyle(fontSize: 18, color: Colors.white),
//                         // fillColor: Colors.red,
//                         // prefixIcon: Icon(Icons.email),
//                         hintText: 'Enter a email address'),
//                     controller: _email,
//                   )),
//               //spacer(10),
//               GestureDetector(
//                 child: (_isLoading)
//                     ? Expanded(
//                         child: CustomAnimationBuilder<double>(
//                             tween: Tween<double>(begin: 0.0, end: 1.0),
//                             duration: const Duration(milliseconds: 500),
//                             builder: (context, value, child) {
//                               return Transform.scale(
//                                   scale: value,
//                                   child: Column(children: [
//                                     Container(
//                                         height: 50,
//                                         width:
//                                             MediaQuery.of(context).size.width <
//                                                     500
//                                                 ? 400
//                                                 : 500,
//                                         decoration: const BoxDecoration(
//                                             color: Color(0xFFcc86ff),
//                                             borderRadius: BorderRadius.only(
//                                               topRight: Radius.circular(10),
//                                               topLeft: Radius.circular(10),
//                                             )),
//                                         child: Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             // mainAxisAlignment:
//                                             //     MainAxisAlignment.center,
//                                             children: [
//                                               Expanded(
//                                                   flex: 4,
//                                                   //fit: FlexFit.tight,
//                                                   child: Container()),
//                                               Expanded(
//                                                   flex: 4,
//                                                   child: Center(
//                                                       child:
//                                                           CircularProgressIndicator(
//                                                     color: Color.fromARGB(
//                                                         239, 236, 210, 255),
//                                                     strokeWidth: 5,
//                                                   ))),
//                                               Expanded(
//                                                   flex: 4, child: Container()),
//                                             ])),
//                                     Container(
//                                       height: 15,
//                                       width: MediaQuery.of(context).size.width <
//                                               500
//                                           ? 400
//                                           : 500,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: const Color(0xFFC371FE),
//                                           width: 3,
//                                         ),
//                                         borderRadius: const BorderRadius.only(
//                                           bottomRight: Radius.circular(10),
//                                           bottomLeft: Radius.circular(10),
//                                         ),
//                                         color: const Color(0xFFC371FE),
//                                       ),
//                                     ),
//                                   ]));
//                             }))
//                     : Expanded(
//                         child: //GestureDetector(
//                             // onTap: () {
//                             //   Navigator.of(context).pushNamed('/login');
//                             // },
//                             //child:
//                             CustomAnimationBuilder<double>(
//                                 // control:
//                                 //     control, // bind variable with control instruction
//                                 tween: Tween<double>(begin: 0.0, end: 1.0),
//                                 duration: const Duration(milliseconds: 500),
//                                 builder: (context, value, child) {
//                                   return Transform.scale(
//                                       scale: value,
//                                       child: Column(children: [
//                                         Container(
//                                             height: 50,
//                                             width: MediaQuery.of(context)
//                                                         .size
//                                                         .width <
//                                                     500
//                                                 ? 400
//                                                 : 500,
//                                             decoration: const BoxDecoration(
//                                                 color: Color(0xFFcc86ff),
//                                                 borderRadius: BorderRadius.only(
//                                                   topRight: Radius.circular(10),
//                                                   topLeft: Radius.circular(10),
//                                                 )),
//                                             child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Container(
//                                                       height: 50,
//                                                       width:
//                                                           MediaQuery.of(context)
//                                                                       .size
//                                                                       .width <
//                                                                   500
//                                                               ? 400
//                                                               : 500,
//                                                       decoration:
//                                                           const BoxDecoration(
//                                                               color: Color(
//                                                                   0xFFcc86ff),
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .only(
//                                                                 topRight: Radius
//                                                                     .circular(
//                                                                         10),
//                                                                 topLeft: Radius
//                                                                     .circular(
//                                                                         10),
//                                                               )),
//                                                       child: Row(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .center,
//                                                           // mainAxisAlignment:
//                                                           //     MainAxisAlignment.center,
//                                                           children: [
//                                                             Expanded(
//                                                                 flex: 2,
//                                                                 //fit: FlexFit.tight,
//                                                                 child: Row(
//                                                                     children: [
//                                                                       Container(
//                                                                         width:
//                                                                             50,
//                                                                         height:
//                                                                             50,
//                                                                         child: RiveAnimation
//                                                                             .asset(
//                                                                           'assets/images/icons/wand.riv',
//                                                                           stateMachines: const [
//                                                                             'game'
//                                                                           ],
//                                                                           animations: const [
//                                                                             'idle'
//                                                                           ],
//                                                                           fit: BoxFit
//                                                                               .contain,
//                                                                         ),
//                                                                       )
//                                                                     ])),
//                                                             Expanded(
//                                                                 flex: 8,
//                                                                 //fit: FlexFit.tight,
//                                                                 child: Center(
//                                                                     child: Text(
//                                                                         "continue with magic link",
//                                                                         style:
//                                                                             TextStyle(
//                                                                           color:
//                                                                               Color(0xFF1a1e4c),
//                                                                           fontSize:
//                                                                               18,
//                                                                           fontFamily:
//                                                                               'Eina',
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                         )))),
//                                                             Expanded(
//                                                                 flex: 2,
//                                                                 //fit: FlexFit.tight,
//                                                                 child:
//                                                                     Container()),
//                                                           ]))
//                                                 ])),
//                                         Container(
//                                           height: 15,
//                                           width: MediaQuery.of(context)
//                                                       .size
//                                                       .width <
//                                                   500
//                                               ? 400
//                                               : 500,
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                               color: const Color(0xFFC371FE),
//                                               width: 3,
//                                             ),
//                                             borderRadius:
//                                                 const BorderRadius.only(
//                                               bottomRight: Radius.circular(10),
//                                               bottomLeft: Radius.circular(10),
//                                             ),
//                                             color: const Color(0xFFC371FE),
//                                           ),
//                                         ),
//                                       ]));
//                                 })),
//                 onTap: () async {
//                   if (!_formKey.currentState!.validate()) {
//                     return;
//                   }
//                   setState(() {
//                     _isLoading = true;
//                   });
//                   try {
//                     await supabase.auth.signInWithOtp(
//                       email: _email.text,
//                       emailRedirectTo: widget.redirectUrl,
//                     );
//                     if (mounted) {
//                       context.showSnackBar('Check your email inbox!');
//                     }
//                   } on AuthException catch (error) {
//                     if (widget.onError == null) {
//                       context.showErrorSnackBar(error.message);
//                     } else {
//                       widget.onError?.call(error);
//                     }
//                   } catch (error) {
//                     if (widget.onError == null) {
//                       context.showErrorSnackBar(
//                           'Unexpected error has occurred: $error');
//                     } else {
//                       widget.onError?.call(error);
//                     }
//                   }
//                   setState(() {
//                     _isLoading = false;
//                   });
//                 },
//               ),
//               spacer(10),
//               Container(
//                 height: 50,
//                 child: Center(
//                     child: Text("Or continue with: ",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontFamily: 'Eina',
//                           fontWeight: FontWeight.bold,
//                         ))),
//               ),
//               //spacer(10),
//               Container(
//                   child: Column(children: [
//                 Container(
//                     //color: Colors.blue,
//                     child: CustomAnimationBuilder<double>(
//                         tween: Tween<double>(begin: 0.0, end: 1.0),
//                         duration: const Duration(milliseconds: 500),
//                         builder: (context, value, child) {
//                           return Transform.scale(
//                               scale: value,
//                               child: Column(children: [
//                                 Container(
//                                     height: 50,
//                                     width:
//                                         MediaQuery.of(context).size.width < 500
//                                             ? 400
//                                             : 500,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.only(
//                                           topRight: Radius.circular(10),
//                                           topLeft: Radius.circular(10),
//                                         )),
//                                     child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                               height: 50,
//                                               width: MediaQuery.of(context)
//                                                           .size
//                                                           .width <
//                                                       500
//                                                   ? 400
//                                                   : 500,
//                                               decoration: const BoxDecoration(
//                                                   color: Colors.white,
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                     topRight:
//                                                         Radius.circular(10),
//                                                     topLeft:
//                                                         Radius.circular(10),
//                                                   )),
//                                               child: Row(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   // mainAxisAlignment:
//                                                   //     MainAxisAlignment.center,
//                                                   children: [
//                                                     Expanded(
//                                                         flex: 2,
//                                                         //fit: FlexFit.tight,
//                                                         child: Row(children: [
//                                                           // Container(
//                                                           //   width: 50,
//                                                           //   height: 50,
//                                                           //   child: RiveAnimation
//                                                           //       .asset(
//                                                           //     'assets/images/icons/wand.riv',
//                                                           //     stateMachines: const [
//                                                           //       'game'
//                                                           //     ],
//                                                           //     animations: const [
//                                                           //       'idle'
//                                                           //     ],
//                                                           //     fit: BoxFit
//                                                           //         .contain,
//                                                           //   ),
//                                                           // )
//                                                         ])),
//                                                     Expanded(
//                                                         flex: 8,
//                                                         //fit: FlexFit.tight,
//                                                         child: Center(
//                                                             child: Text("apple",
//                                                                 style:
//                                                                     TextStyle(
//                                                                   color: Color(
//                                                                       0xFF1a1e4c),
//                                                                   fontSize: 18,
//                                                                   fontFamily:
//                                                                       'Eina',
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                 )))),
//                                                     Expanded(
//                                                         flex: 2,
//                                                         //fit: FlexFit.tight,
//                                                         child: Container()),
//                                                   ]))
//                                         ])),
//                                 Container(
//                                   height: 15,
//                                   width: MediaQuery.of(context).size.width < 500
//                                       ? 400
//                                       : 500,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: const Color.fromARGB(
//                                           255, 229, 229, 229),
//                                       width: 3,
//                                     ),
//                                     borderRadius: const BorderRadius.only(
//                                       bottomRight: Radius.circular(10),
//                                       bottomLeft: Radius.circular(10),
//                                     ),
//                                     color: Color.fromARGB(255, 229, 229, 229),
//                                   ),
//                                 ),
//                               ]));
//                         })),
//                 //spacer(10),
//                 Container(
//                     //color: Colors.red,
//                     child: CustomAnimationBuilder<double>(
//                         tween: Tween<double>(begin: 0.0, end: 1.0),
//                         duration: const Duration(milliseconds: 500),
//                         builder: (context, value, child) {
//                           return Transform.scale(
//                               scale: value,
//                               child: Column(children: [
//                                 Container(
//                                     height: 50,
//                                     width:
//                                         MediaQuery.of(context).size.width < 500
//                                             ? 400
//                                             : 500,
//                                     decoration: const BoxDecoration(
//                                         color: Color(0xFF00ff79),
//                                         borderRadius: BorderRadius.only(
//                                           topRight: Radius.circular(10),
//                                           topLeft: Radius.circular(10),
//                                         )),
//                                     child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                               height: 50,
//                                               width: MediaQuery.of(context)
//                                                           .size
//                                                           .width <
//                                                       500
//                                                   ? 400
//                                                   : 500,
//                                               decoration: const BoxDecoration(
//                                                   color: Color(0xFF00ff79),
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                     topRight:
//                                                         Radius.circular(10),
//                                                     topLeft:
//                                                         Radius.circular(10),
//                                                   )),
//                                               child: Row(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   // mainAxisAlignment:
//                                                   //     MainAxisAlignment.center,
//                                                   children: [
//                                                     Expanded(
//                                                         flex: 2,
//                                                         //fit: FlexFit.tight,
//                                                         child: Row(children: [
//                                                           // Container(
//                                                           //   width: 50,
//                                                           //   height: 50,
//                                                           //   child:
//                                                           //   RiveAnimation
//                                                           //       .asset(
//                                                           //     'assets/images/icons/wand.riv',
//                                                           //     stateMachines: const [
//                                                           //       'game'
//                                                           //     ],
//                                                           //     animations: const [
//                                                           //       'idle'
//                                                           //     ],
//                                                           //     fit: BoxFit
//                                                           //         .contain,
//                                                           //   ),
//                                                           // )
//                                                         ])),
//                                                     Expanded(
//                                                         flex: 8,
//                                                         //fit: FlexFit.tight,
//                                                         child: Center(
//                                                             child: Text(
//                                                                 "google",
//                                                                 style:
//                                                                     TextStyle(
//                                                                   color: Color(
//                                                                       0xFF1a1e4c),
//                                                                   fontSize: 18,
//                                                                   fontFamily:
//                                                                       'Eina',
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                 )))),
//                                                     Expanded(
//                                                         flex: 2,
//                                                         //fit: FlexFit.tight,
//                                                         child: Container()),
//                                                   ]))
//                                         ])),
//                                 Container(
//                                   height: 15,
//                                   width: MediaQuery.of(context).size.width < 500
//                                       ? 400
//                                       : 500,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: const Color(0xFF21de6b),
//                                       width: 3,
//                                     ),
//                                     borderRadius: const BorderRadius.only(
//                                       bottomRight: Radius.circular(10),
//                                       bottomLeft: Radius.circular(10),
//                                     ),
//                                     color: const Color(0xFF21de6b),
//                                   ),
//                                 ),
//                               ]));
//                         })),
//                 //spacer(10),
//                 Container(
//                     //color: Colors.red,
//                     child: CustomAnimationBuilder<double>(
//                         tween: Tween<double>(begin: 0.0, end: 1.0),
//                         duration: const Duration(milliseconds: 500),
//                         builder: (context, value, child) {
//                           return Transform.scale(
//                               scale: value,
//                               child: Column(children: [
//                                 Container(
//                                     height: 50,
//                                     width:
//                                         MediaQuery.of(context).size.width < 500
//                                             ? 400
//                                             : 500,
//                                     decoration: const BoxDecoration(
//                                         color: Color(0xFFcc86ff),
//                                         borderRadius: BorderRadius.only(
//                                           topRight: Radius.circular(10),
//                                           topLeft: Radius.circular(10),
//                                         )),
//                                     child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                               height: 50,
//                                               width: MediaQuery.of(context)
//                                                           .size
//                                                           .width <
//                                                       500
//                                                   ? 400
//                                                   : 500,
//                                               decoration: const BoxDecoration(
//                                                   color: Color(0xFF01cb0f6),
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                     topRight:
//                                                         Radius.circular(10),
//                                                     topLeft:
//                                                         Radius.circular(10),
//                                                   )),
//                                               child: Row(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   // mainAxisAlignment:
//                                                   //     MainAxisAlignment.center,
//                                                   children: [
//                                                     Expanded(
//                                                         flex: 2,
//                                                         //fit: FlexFit.tight,
//                                                         child: Row(children: [
//                                                           // Container(
//                                                           //   width: 50,
//                                                           //   height: 50,
//                                                           //   child: RiveAnimation
//                                                           //       .asset(
//                                                           //     'assets/images/icons/wand.riv',
//                                                           //     stateMachines: const [
//                                                           //       'game'
//                                                           //     ],
//                                                           //     animations: const [
//                                                           //       'idle'
//                                                           //     ],
//                                                           //     fit: BoxFit
//                                                           //         .contain,
//                                                           //   ),
//                                                           // )
//                                                         ])),
//                                                     Expanded(
//                                                         flex: 8,
//                                                         //fit: FlexFit.tight,
//                                                         child: Center(
//                                                             child: Text(
//                                                                 "facebook",
//                                                                 style:
//                                                                     TextStyle(
//                                                                   color: Color(
//                                                                       0xFF1a1e4c),
//                                                                   fontSize: 18,
//                                                                   fontFamily:
//                                                                       'Eina',
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                 )))),
//                                                     Expanded(
//                                                         flex: 2,
//                                                         //fit: FlexFit.tight,
//                                                         child: Container()),
//                                                   ]))
//                                         ])),
//                                 Container(
//                                   height: 15,
//                                   width: MediaQuery.of(context).size.width < 500
//                                       ? 400
//                                       : 500,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: const Color(0xFF0088c8),
//                                       width: 3,
//                                     ),
//                                     borderRadius: const BorderRadius.only(
//                                       bottomRight: Radius.circular(10),
//                                       bottomLeft: Radius.circular(10),
//                                     ),
//                                     color: const Color(0xFF0088c8),
//                                   ),
//                                 ),
//                               ]));
//                         }))
//               ])),
//               //spacer(10),
//               Container(
//                   //color: Colors.red,
//                   child: CustomAnimationBuilder<double>(
//                       tween: Tween<double>(begin: 0.0, end: 1.0),
//                       duration: const Duration(milliseconds: 500),
//                       builder: (context, value, child) {
//                         return Transform.scale(
//                             scale: value,
//                             child: Column(children: [
//                               Container(
//                                   height: 50,
//                                   width: MediaQuery.of(context).size.width < 500
//                                       ? 400
//                                       : 500,
//                                   decoration: const BoxDecoration(
//                                       color: Color.fromARGB(255, 126, 136, 255),
//                                       borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(10),
//                                         topLeft: Radius.circular(10),
//                                       )),
//                                   child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                             height: 50,
//                                             width: MediaQuery.of(context)
//                                                         .size
//                                                         .width <
//                                                     500
//                                                 ? 400
//                                                 : 500,
//                                             decoration: const BoxDecoration(
//                                                 color: Color.fromARGB(
//                                                     255, 126, 136, 255),
//                                                 borderRadius: BorderRadius.only(
//                                                   topRight: Radius.circular(10),
//                                                   topLeft: Radius.circular(10),
//                                                 )),
//                                             child: Row(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 // mainAxisAlignment:
//                                                 //     MainAxisAlignment.center,
//                                                 children: [
//                                                   Expanded(
//                                                       flex: 2,
//                                                       //fit: FlexFit.tight,
//                                                       child: Row(children: [
//                                                         // Container(
//                                                         //   width: 50,
//                                                         //   height: 50,
//                                                         //   child:
//                                                         //   RiveAnimation
//                                                         //       .asset(
//                                                         //     'assets/images/icons/wand.riv',
//                                                         //     stateMachines: const [
//                                                         //       'game'
//                                                         //     ],
//                                                         //     animations: const [
//                                                         //       'idle'
//                                                         //     ],
//                                                         //     fit: BoxFit
//                                                         //         .contain,
//                                                         //   ),
//                                                         // )
//                                                       ])),
//                                                   Expanded(
//                                                       flex: 8,
//                                                       //fit: FlexFit.tight,
//                                                       child: Center(
//                                                           child: Text("discord",
//                                                               style: TextStyle(
//                                                                 color: Color(
//                                                                     0xFF1a1e4c),
//                                                                 fontSize: 18,
//                                                                 fontFamily:
//                                                                     'Eina',
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                               )))),
//                                                   Expanded(
//                                                       flex: 2,
//                                                       //fit: FlexFit.tight,
//                                                       child: Container()),
//                                                 ]))
//                                       ])),
//                               Container(
//                                 height: 15,
//                                 width: MediaQuery.of(context).size.width < 500
//                                     ? 400
//                                     : 500,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: Color.fromARGB(255, 81, 93, 224),
//                                     width: 3,
//                                   ),
//                                   borderRadius: const BorderRadius.only(
//                                     bottomRight: Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                   ),
//                                   color: Color.fromARGB(255, 81, 93, 224),
//                                 ),
//                               ),
//                             ]));
//                       })),
//               //spacer(10),
//               Container(
//                   width: 500,
//                   padding: const EdgeInsets.all(20),
//                   child: Column(children: [
//                     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                       Text("By continuing in to ",
//                           style: TextStyle(
//                             color: Color(0xFFC371FE),
//                             fontSize: 16,
//                             fontFamily: 'Eina',
//                             fontWeight: FontWeight.bold,
//                           )),
//                       GestureDetector(
//                         onTap: () async {
//                           launchUrl(Uri.parse('https://corgis.ai'));
//                         },
//                         child: Text(
//                           "corgis.ai",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontFamily: 'Eina',
//                             fontWeight: FontWeight.bold,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                       Text(", you  agree to our ",
//                           style: TextStyle(
//                             color: Color(0xFFC371FE),
//                             fontSize: 16,
//                             fontFamily: 'Eina',
//                             fontWeight: FontWeight.bold,
//                           )),
//                     ]),
//                     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                       GestureDetector(
//                         onTap: () async {
//                           launchUrl(Uri.parse('https://corgis.ai'));
//                         },
//                         child: Text(
//                           "Terms of Service",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontFamily: 'Eina',
//                             fontWeight: FontWeight.bold,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                       Text(" and ",
//                           style: TextStyle(
//                             color: Color(0xFFC371FE),
//                             fontSize: 16,
//                             fontFamily: 'Eina',
//                             fontWeight: FontWeight.bold,
//                           )),
//                       GestureDetector(
//                         onTap: () async {
//                           launchUrl(Uri.parse('https://corgis.ai'));
//                         },
//                         child: Text(
//                           "Privacy Policy",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontFamily: 'Eina',
//                             fontWeight: FontWeight.bold,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       )
//                     ])
//                   ])),
//               //spacer(10),

//               // Container(
//               //     child: Text(
//               //   "By continuing in to Corgis.ai, you agree to our Terms of Service and Privacy Policy",
//               //   style: TextStyle(
//               //     color: Color(0xFFC371FE),
//               //     fontSize: 12,
//               //     fontFamily: 'Eina',
//               //     fontWeight: FontWeight.bold,
//               //   ),
//               // ))
//             ],
//           ),
//         )));
//   }
// }

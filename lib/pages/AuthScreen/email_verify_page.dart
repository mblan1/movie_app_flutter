import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test1/firebase/FirebaseService.dart';
import 'package:test1/pages/MovieScreen/home_page.dart';
import 'package:test1/utils/WidgetVoid.dart';
import 'package:test1/utils/timer.dart';
import 'package:test1/widget/loading_screen.dart';

class MailVerifyPage extends StatefulWidget {
  const MailVerifyPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<StatefulWidget> createState() => _MailVerifyPage();
}

class _MailVerifyPage extends State<MailVerifyPage> {
  late bool isLoading = false;
  late bool isFirstSend;
  late int _coolDownSecond;
  late String? _hidedEmail;
  var isEmailVerified = false;
  var _isOnCoolDown = false;

  late Timer timer;
  late int coolDownTime = TimerCustom.getTimeLeft();

  @override
  void initState() {
    super.initState();
    hideEmailAddress(widget.user.email!);
    if (coolDownTime > 0) {
      setState(() {
        isFirstSend = false;
      });
      onCoolDown(coolDownTime);
    } else {
      setState(() {
        isFirstSend = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    // dispose timer
    if (timer.isActive) {
      timer.cancel();
    }
  }

  void handleFocusChange(value) {
    if (value.isNotEmpty) {
      FocusScope.of(context).nextFocus();
    } else if (value.isEmpty) {
      FocusScope.of(context).previousFocus();
    }
  }

  void onCoolDown(int time) {
    timer = Timer(const Duration(seconds: 1), () {
      setState(() {
        time--;
      });
      if (time > 0) {
        onCoolDown(time);
        setState(() {
          _isOnCoolDown = true;
          _coolDownSecond = time;
          TimerCustom.setTime(time);
          TimerCustom.getTimeLeft();
        });
      } else {
        setState(() {
          _isOnCoolDown = false;
        });
      }
    });
  }

  void hideEmailAddress(String email) {
    final List<String> splitEmail = email.split("@");
    final String firstPart = splitEmail[0];
    final String secondPart = splitEmail[1];
    final String hideFirstPart =
        "${firstPart.substring(0, 2)}${"*" * (firstPart.length - 2)}@$secondPart";
    setState(() {
      _hidedEmail = hideFirstPart;
    });
  }

  @override
  Widget build(BuildContext context) {
    // get user
    final User user = widget.user;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            FirebaseService.signOut();
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 62, left: 20, right: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xff2B5876),
              Color(0xff4E4376),
            ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const Text(
                        "Almost there!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // Check your email
                      const Text(
                        "Check your email for the verification code",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // user email
                      Text(
                        _hidedEmail!,
                        style:
                            const TextStyle(color: Colors.orange, fontSize: 18),
                      ),

                      // mail verification status icon
                      Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Stack(
                            children: [
                              const Icon(
                                Icons.mail,
                                color: Colors.white,
                                size: 100,
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: isEmailVerified
                                          ? Colors.green
                                          : Colors.red,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Icon(
                                      isEmailVerified
                                          ? Icons.check
                                          : Icons.close_outlined,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  )),
                            ],
                          )),

                      // verify status and Continue Button
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: 64,
                        width: double.infinity,
                        child: Row(
                          children: [
                            // verify status
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                margin: const EdgeInsets.all(4),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.orange.withOpacity(.8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await FirebaseService.reloadUser()
                                        .then((user) {
                                      if (user != null) {
                                        if (user.emailVerified) {
                                          setState(() {
                                            isEmailVerified = true;
                                          });
                                          WidgetVoid.showSnackBar(
                                            context,
                                            "Your email is verified",
                                            backgroundColor: Colors.green,
                                          );
                                        } else {
                                          WidgetVoid.showSnackBar(
                                            context,
                                            "Your email is not verified",
                                            backgroundColor: Colors.red,
                                          );
                                        }
                                      }
                                    });
                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                  child: const Text("Check status"),
                                ),
                              ),
                            ),

                            // Continue Button
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                height: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (isEmailVerified) {
                                      await Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(
                                            user: user,
                                          ),
                                        ),
                                      );
                                    } else {
                                      WidgetVoid.showSnackBar(
                                        context,
                                        "Please verify your email",
                                        backgroundColor: Colors.red,
                                      );
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                  child: const Text("Continue"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // resend mail verification
                      if (!isEmailVerified)
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            if (isFirstSend) {
                              await FirebaseService.sendVerificationEmail(user);
                              onCoolDown(60);
                              setState(() {
                                isFirstSend = false;
                              });
                            } else if (!_isOnCoolDown) {
                              await FirebaseService.sendVerificationEmail(user);
                              onCoolDown(60);
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Text(
                            isFirstSend
                                ? "Send Verification"
                                : _isOnCoolDown
                                    ? "Wait $_coolDownSecond seconds to resend"
                                    : "Resend verification mail",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // loading screen
          if (isLoading) const LoadingScreen(),
        ],
      ),
    );
  }
}

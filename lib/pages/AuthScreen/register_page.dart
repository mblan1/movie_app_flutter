import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test1/firebase/FirebaseService.dart';
import 'package:test1/pages/AuthScreen/email_verify_page.dart';
import 'package:test1/pages/MovieScreen/home_page.dart';
import 'package:test1/widget/loading_screen.dart';
import 'package:test1/utils/WidgetVoid.dart';
import 'package:test1/widget/reUseTextForm.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // user
  late User user;

  late bool isLoading = false;
  late bool isHidePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void handleSignUpWithEmail(User user) {
    if (!user.emailVerified) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MailVerifyPage(
            user: user,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            user: user,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff2B5876),
          Color(0xff4E4376),
        ])),
        child: Stack(
          children: [
            textForm(context),
            if (isLoading) const LoadingScreen(),
          ],
        ),
      ),
    );
  }

  Form textForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(28),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // username
                ReUseTextForm(
                  textController: _usernameController,
                  textLabel: "Username",
                  isHidingText: false,
                  inputName: "username",
                ),

                const SizedBox(
                  height: 20,
                ),

                // email
                ReUseTextForm(
                  textController: _emailController,
                  textLabel: "Email",
                  isHidingText: false,
                  inputName: "email",
                ),

                const SizedBox(
                  height: 20,
                ),

                // password
                Stack(
                  children: [
                    ReUseTextForm(
                      textController: _passwordController,
                      textLabel: "Password",
                      isHidingText: isHidePassword,
                      inputName: "password",
                      isShowPasswordBtn: true,
                      onTogglePassword: () {
                        setState(() {
                          isHidePassword = !isHidePassword;
                        });
                      },
                    ),

                    // show password
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                // register button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      // confirm  register
                      await FirebaseService.signUpWithEmailAndPassword(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                        userName: _usernameController.text.trim(),
                      ).then(
                        (user) {
                          if (user != null) {
                            handleSignUpWithEmail(user);
                          } else {
                            WidgetVoid.showSnackBar(
                              context,
                              "Email is already in use!",
                              backgroundColor: Colors.red,
                            );
                          }
                        },
                      ).catchError(
                        (error) {
                          WidgetVoid.showSnackBar(
                            context,
                            "Something went wrong!",
                            backgroundColor: Colors.red,
                          );
                          print(error.toString());
                        },
                      );
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: const Text("Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

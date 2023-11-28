import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test1/firebase/FirebaseService.dart';
import 'package:test1/modals/login_method.dart';
import 'package:test1/pages/homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  void showSnackBar(BuildContext context, String message,
      {backgroundColor = Colors.blue}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        backgroundColor: backgroundColor,
      ),
    );
  }

  // handle login
  void handleLogin(bool condition, String route,
      {String elseMessage = "missing"}) {
    if (condition) {
      FirebaseService.signInWithGoogle();
    } else {
      showSnackBar(context, elseMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // padding: const EdgeInsets.all(28),
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff2B5876),
          Color(0xff4E4376),
        ])),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                thumbnail(),
                title(),

                // Text Field
                textForm(context),

                // login media
                loginMethod(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Image thumbnail() {
    return Image.asset('assets/images/app_thumb.png', width: 200, height: 200);
  }

  Container title() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Text(
        'Hi not Smile',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  SizedBox loginMethod() {
    return SizedBox(
      height: 50,
      width: 168,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 10),
        scrollDirection: Axis.horizontal,
        itemCount: loginMethods.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
                icon: SvgPicture.asset(
                  loginMethods[index].icon,
                  width: 30,
                  height: 30,
                ),
                onPressed: () {
                  handleLogin(
                    loginMethods[index].isActive,
                    loginMethods[index].route,
                    elseMessage:
                        "Tinh nang dang bao tri vui long dang nhap bang phuong thuc khac !",
                  );
                }

                // Navigator.pushReplacementNamed(
                //     context, '/homePage'),
                ),
          );
        },
      ),
    );
  }

  Form textForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // mail
            TextFormField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                  ),
                ),
                border: OutlineInputBorder(),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                //
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!value.contains('@')) {
                  return 'Please enter a valid email address';
                } else if (value.length > 50) {
                  return 'Email must be less than 50 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // password
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                  ),
                ),
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                } else if (value.length > 20) {
                  return 'Password must be less than 20 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FirebaseService.signUpWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                      onSuccess: () =>
                          Navigator.pushReplacementNamed(context, '/homePage'),
                      onError: () => showSnackBar(
                        context,
                        "Account already exist",
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:test1/pages/homePage.dart';
import 'package:test1/pages/loginPage.dart';
import 'package:test1/pages/registerPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        // "/homePage": (context) => HomePage(),
        "/registerPage": (context) => const RegisterPage(),
        "/loginPage": (context) => const LoginPage(),
      },
    );
  }
}

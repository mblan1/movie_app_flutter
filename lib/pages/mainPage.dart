import 'package:flutter/material.dart';
import 'package:test1/pages/homePage.dart';
import 'package:test1/pages/loginPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/homePage": (context) => HomePage(),
        "/loginPage": (context) => LoginPage(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:test1/BottomBar/CustomBottomBar.dart';
import 'package:test1/pages/homePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HomePage(),
        bottomNavigationBar: CustomBottomBar(),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "BeVietNamPro"),
    );
  }
}

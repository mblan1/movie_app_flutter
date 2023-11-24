import 'package:flutter/material.dart';
import 'package:test1/pages/homePage.dart';
import 'package:test1/pages/mainPage.dart';

void main() {
  runApp(
    MaterialApp(
      home: const SafeArea(
        child: MainPage(),
      ),
      theme: ThemeData(fontFamily: "BeVietNamPro"),
      debugShowCheckedModeBanner: false,
    ),
  );
}

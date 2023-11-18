import 'package:flutter/material.dart';
import 'package:test1/pages/homePage.dart';

void main() {
  runApp(MaterialApp(
    home: SafeArea(
      child: HomePage(),
    ),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: "BeVietNamPro"),
  ));
}

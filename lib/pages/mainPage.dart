import 'package:flutter/material.dart';
import 'package:test1/pages/fullScreenVideo.dart';
import 'package:test1/pages/homePage.dart';
import 'package:test1/pages/movieDetail.dart';
import 'package:test1/pages/watchMoviePage.dart';
import 'package:test1/pages/youtubePlayer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

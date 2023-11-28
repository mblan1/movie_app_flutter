import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test1/pages/mainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyCd0KR_Sr-XG0dJqYK8D9rntEn-KndCVxg',
            appId: '1:311102940719:android:c429884560e6997f4e08da',
            messagingSenderId: '311102940719',
            projectId: 'movieapp-dd3c3',
          ),
        )
      : Firebase.initializeApp();

  // await FirebaseAuth.instance.useAuthEmulator("localhost", 9099);
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

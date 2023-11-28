import 'package:flutter/material.dart';
import 'package:quadb_tech/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

late Size mq;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black, fontFamily: 'Urbanist'),
      title: "Assignment",
      home: const SplashScreen(),
    );
  }
}

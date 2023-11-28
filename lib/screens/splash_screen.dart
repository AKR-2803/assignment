import 'package:flutter/material.dart';
import 'package:quadb_tech/constants/constants.dart';
import 'package:quadb_tech/main.dart';
import 'package:quadb_tech/screens/bottom_navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context)
          .pushReplacement(Constants.createRoute(const BottomNavbar()));
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    //using MediaQuery to get device height, width

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        //to animate the app icon
        Center(
          child: SizedBox(
            // color: Colors.white,
            width: mq.width * 0.5,
            child: Image.asset(
              'assets/images/appicon.png',
              scale: 0.7,
            ),
          ),
        ),
        const Text(
          "© QuadB Technologies",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ]),
    );
  }
}

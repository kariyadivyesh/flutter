import 'dart:async';

import 'package:flutter/material.dart';
import 'package:splitify/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.indigoAccent,
      child: SafeArea(
        child: Image(
          image: AssetImage('assets/images/splash.png'),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    ));
  }
}

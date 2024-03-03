import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/MainScreen.dart';
import 'package:smartex/screens/login/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static final String id = "splash_screen";
  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      //Navigator.of(context).pushNamed(LoginSreen.id);
      Navigator.of(context).pushReplacementNamed(LoginSreen.id);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const LoginSreen()),
      // );
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: kLogoS,
      ),
    );
  }
}

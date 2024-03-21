import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartex/components/ResponsiveManager.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/MainScreen.dart';
import 'package:smartex/screens/login/LoginScreen.dart';
import 'package:smartex/storage/LocalStorage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static final String id = "splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool checkAuth = false;

  isAuth() async {
    checkAuth = await LocalStorage.checkAuth();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    isAuth();

      Timer(const Duration(seconds: 3), () {
        if (!checkAuth) {
          Navigator.of(context).pushReplacementNamed(LoginSreen.id);
        } else {
          Navigator.of(context).pushReplacementNamed(MainScreen.id);
        }
      });

  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                kLogoXS(cWidth: 150),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Smartex",
              style: GoogleFonts.alice(
                  color: kPrimaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

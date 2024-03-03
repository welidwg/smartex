import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/responsive/responsive_layout.dart';
import 'package:smartex/screens/login/MobileLogin.dart';
import 'package:smartex/screens/login/TabletLogin.dart';

class LoginSreen extends StatefulWidget {
  const LoginSreen({Key? key}) : super(key: key);
  static const String id = "login_screen";

  @override
  State<LoginSreen> createState() => _LoginSreenState();
}

class _LoginSreenState extends State<LoginSreen> {

  @override
  Widget build(BuildContext context) {
    return const  SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CupertinoColors.white,
        body: Center(
          child:   ResponsiveLayout(desktopBody: TabletLogin(), mobileBody: SingleChildScrollView(child: MobileLogin()),),
        )
      ),
    );
  }
}



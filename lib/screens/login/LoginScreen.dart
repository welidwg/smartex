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
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: CupertinoColors.white,
          body: width > kMobileWidth
              ? const TabletLogin()
              :  const SingleChildScrollView(child: MobileLogin())),
    );
  }
}

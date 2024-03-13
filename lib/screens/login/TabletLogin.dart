import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Modals/BlurredModal.dart';
import 'package:smartex/components/Titles/HeadLine.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/MainScreen.dart';
import 'package:smartex/screens/home/HomeScreen.dart';
import 'package:smartex/screens/login/LoginForm.dart';
import 'package:smartex/screens/login/PasswordRecovery.dart';

class TabletLogin extends StatefulWidget {
  const TabletLogin({super.key});

  @override
  State<TabletLogin> createState() => _TabletLoginState();
}

class _TabletLoginState extends State<TabletLogin> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.elliptical(35, 200),
                    bottomRight: Radius.elliptical(35, 200))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    kLogoPrimaryXS(cWidth: 250),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text("Smartex",
                      style: GoogleFonts.alice(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 45)),
                )
              ],
            ),
          ),
        ),
        const Expanded(
            child: Padding(
          padding: EdgeInsets.all(18.0),
          child: LoginForm(),
        ))
      ],
    );
  }
}

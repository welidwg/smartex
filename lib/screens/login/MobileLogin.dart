import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Modals/BlurredModal.dart';
import 'package:smartex/components/Titles/HeadLine.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/MainScreen.dart';
import 'package:smartex/screens/home/HomeScreen.dart';
import 'package:smartex/screens/login/LoginForm.dart';
import 'package:smartex/screens/login/PasswordRecovery.dart';

class MobileLogin extends StatelessWidget {
  const MobileLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height:380,
            decoration:  BoxDecoration(
              color: kPrimaryColor.withOpacity(1),
              borderRadius: const BorderRadius.only(bottomLeft: Radius.elliptical(200, 35),bottomRight:Radius.elliptical(200, 35) )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: kLogoPrimaryXS(cWidth: 150)),
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
                          fontSize: 35)),
                )
              ],
            ),
          ),
           const Expanded(child: LoginForm())
        ],
      ),
    );
  }
}

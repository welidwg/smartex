import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Modals/BlurredModal.dart';
import 'package:smartex/components/Titles/HeadLine.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/MainScreen.dart';
import 'package:smartex/screens/home/HomeScreen.dart';
import 'package:smartex/screens/login/PasswordRecovery.dart';

class MobileLogin extends StatelessWidget {
  const MobileLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [kLogoXS()],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Identifiez-Vous",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 27,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
                width: width - 50,
                child: Input(
                    label: "Nom d'utilisateur",
                    is_Password: false,
                    onChange: (value) {})),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
                width: width - 50,
                child: Input(
                    label: "Mot de passe",
                    is_Password: true,
                    onChange: (value) {})),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: width - 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: MyActionButton(
                      label: "Connexion",
                      color: kPrimaryColor,
                      icon: Icons.login,
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(MainScreen.id);
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isDismissible: false,
                    builder: ((context) {
                      return const PasswordRecovery();
                    }),
                    isScrollControlled: true,
                  );
                },
                child: const Text(
                  "Mot de passe oubliée?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kPrimaryColor),
                ))
          ],
        )
      ],
    );
  }
}

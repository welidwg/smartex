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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [kLogoL],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Identifiez-Vous",
              style: TextStyle(fontSize: 45, color: kPrimaryColor),
            ),
            const SizedBox(
              height: 29,
            ),
            SizedBox(
                width: 350,
                child: Input(
                    label: "Nom d'utilisateur",
                    is_Password: false,
                    onChange: (value) {})),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
                width: 350,
                child: Input(
                    label: "Mot de passe",
                    is_Password: true,
                    onChange: (value) {})),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      child: MyActionButton(
                    label: "Connexion",
                    color: kPrimaryColor,
                    icon: Icons.login,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(MainScreen.id);
                    },
                  ))
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
                  isScrollControlled: true,
                  context: context,
                  isDismissible: false,
                  builder: ((context) {
                    return const PasswordRecovery();
                  }),

                );
                // showCupertinoModalBottomSheet(
                //     barrierColor: kPrimaryColor.withOpacity(0.5),
                //     context: context,
                //     builder: ((context) {
                //       return Padding(
                //         padding: EdgeInsets.only(bottom: 30),
                //         child: Container(
                //           width: width,
                //           height: width>kMobileWidth ? height*0.6 : height/3,
                //           color: CupertinoColors.white,
                //           child: Scaffold(
                //             backgroundColor: CupertinoColors.white,
                //             body: Center(child: PasswordRecovery()),
                //           ),
                //         ),
                //       );
                //     }));
              },
              child: Text(
                "Mot de passe oubliée ?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontSize: kTabletFont),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }
}

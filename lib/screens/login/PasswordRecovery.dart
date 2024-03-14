import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/ResponsiveManager.dart';
import 'package:smartex/components/Titles/HeadLine.dart';
import 'package:smartex/constants.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: CupertinoColors.white),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            HeadLine(
              title: "Récupération du mot de passe",
              fontS: ResponsiveManager.setFont(context)+2,
              color: kPrimaryColor,
              icon: Icons.refresh,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info,
                      color: kPrimaryColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        "Afin de récuperer votre mot de passe, vous devez envoyer une réclamation à l'administrateur.\nVeuillez saisir votre nom d'utilisateur",
                        textAlign: TextAlign.start,
                        style: kContentTextStyle(
                            customFontSize: width > kMobileWidth
                                ? kTabletFont-2
                                : kMobileFont - 2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Input(
                label: "Nom d'utilisateur",
                is_Password: false,
                onChange: (value) {}),
            const SizedBox(
              height: 10,
            ),
            MyActionButton(
              label: "Envoyer une demande",
              color: kPrimaryColor,
              icon: Icons.check,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

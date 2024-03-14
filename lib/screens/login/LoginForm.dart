import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartex/Api/users/UsersRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Modals/ModalManager.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/MainScreen.dart';
import 'package:smartex/screens/login/PasswordRecovery.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  UsersRequestManager manager = UsersRequestManager();
  bool isLoading = false;

  _authUser(BuildContext context) async {
    Map<String, dynamic> data = {
      "username": usernameCtrl.text,
      "password": passwordCtrl.text
    };
    var res = await manager.authUser(data);
    if (res["type"] == "success") {
      await storage.write(key: 'token', value: res["token"]);
      await storage.write(key: 'user', value: json.encode(res["user"]));
      Navigator.of(context).pushReplacementNamed(MainScreen.id);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res["message"])));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           SizedBox(
             width: width-50,
             child: Row(
               children: [
                 Text(
                   "Identifiez-Vous",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                       fontSize: width>kMobileWidth ? kTabletFont+9 : kMobileFont+7,
                       color: kPrimaryColor,
                       fontWeight: FontWeight.bold),
                 ),
               ],
             ),
           ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
              width: width - 50,
              child: Input(
                  label: "Nom d'utilisateur",
                  controller: usernameCtrl,
                  is_Password: false,
                  message: "Veuillez saisir votre nom d'utilisateur",
                  onChange: (value) {})),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
              width: width - 50,
              child: Input(
                  label: "Mot de passe",
                  controller: passwordCtrl,
                  message: "Veuillez saisir votre mot de passe",
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
                    isLoading: isLoading,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        await _authUser(context);
                      }
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
                // showModalBottomSheet(
                //   backgroundColor: Colors.transparent,
                //   constraints: BoxConstraints(maxWidth: width>kMobileWidth ? width*0.5 : width),
                //   context: context,
                //   isDismissible: false,
                //   builder: ((context) {
                //     return const PasswordRecovery();
                //   }),
                //   isScrollControlled: true,
                // );
                ModalManager.showModal(content: const PasswordRecovery(), context: context);
              },
              child: const Center(
                child: Text(
                  "Mot de passe oubliée?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kPrimaryColor),
                ),
              )),
          const CustomSpacer(),
          const CustomSpacer(),
        ],
      ),
    );
  }
}

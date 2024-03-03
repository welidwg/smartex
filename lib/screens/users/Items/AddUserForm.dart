import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomDropdown.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Titles/HeadLine.dart';
import 'package:smartex/constants.dart';

class AddUserForm extends StatefulWidget {
  AddUserForm({super.key, this.stateSetter});

  StateSetter? stateSetter;

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  String? selectedRole = 'Technicien';
  String test = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: CupertinoColors.white),
        padding: EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeadLine(
                title: "Ajouter un utilisateur",
                fontS: kMobileTitleFont,
                color: kPrimaryColor,
                icon: Icons.supervised_user_circle_sharp,
              ),
              const SizedBox(
                height: 20,
              ),

              Input(
                  label: "Nom d'utilisateur",
                  is_Password: false,
                  onChange: (value) {
                    setState(() {
                      test = value;
                    });
                  }),
              const SizedBox(
                height: 8,
              ),
              Input(
                  label: "Mot de passe",
                  is_Password: true,
                  onChange: (value) {}),
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Sélectionnez un role :',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: width > kMobileWidth ? 18 : 13),
                    ),
                  ),
                  CustomDropdown(items: ['Administrateur', 'Technicien'], defaultItem: "Technicien"),

                  SizedBox(
                    height: 8,
                  ),
                  MyActionButton(label: "Ajouter", color: kPrimaryColor)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

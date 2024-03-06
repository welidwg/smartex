import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/Api/ApiManager.dart';
import 'package:smartex/Api/users/UsersRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomDropdown.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Titles/HeadLine.dart';
import 'package:smartex/constants.dart';
import 'package:alert/alert.dart';

class AddUserForm extends StatefulWidget {
  AddUserForm({super.key, this.stateSetter, this.context, this.updateView});

  StateSetter? stateSetter;
  BuildContext? context;
  Function? updateView;

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  int selectedValue = 0;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  UsersRequestManager manager = UsersRequestManager();
  late Map<int, dynamic> roles = {0:'Administrateur',1:'Technicien'};
  late List<dynamic> users = [];
  final formKey = GlobalKey<FormState>();
  bool isLoading=false;

  @override
  void initState() {
    super.initState();
    // roles[0] = "Administrateur";
    // roles[1] = "Technicien";
  }

  _setRole(int value) {
    setState(() {
      selectedValue = value;
    });
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
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                    onChange: (value) {},
                    controller: username,
                    message: "Veuillez saisir le nom d'utilisateur"),
                const SizedBox(
                  height: 8,
                ),
                Input(
                    label: "Mot de passe",
                    is_Password: true,
                    onChange: (value) {},
                    controller: password,
                    message: "Veuillez saisir le mot de passe"),
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
                    CustomDropdown(
                        items: roles, defaultItem: 0, setter: _setRole),
                    const SizedBox(
                      height: 8,
                    ),
                    MyActionButton(
                      label: "Ajouter",
                      isLoading: isLoading,
                      color: kPrimaryColor,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading=true;
                          });
                          Map<String, dynamic> donnees = {
                            'username': username.text,
                            'password': password.text,
                            'role': selectedValue,
                          };
                          var res = await manager.addUser(donnees);
                          if (res['type'] == "success") {
                            formKey.currentState?.reset();
                            username.clear();
                            password.clear();
                            widget.updateView!();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(widget.context!).showSnackBar(
                                SnackBar(content: Text(res['message'])));
                            setState(() {
                              isLoading=false;
                            });
                          } else {
                            print(res['message']);
                          }
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

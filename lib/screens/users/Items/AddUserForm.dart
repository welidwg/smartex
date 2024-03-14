import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/Api/ApiManager.dart';
import 'package:smartex/Api/roles/RolesRequestManager.dart';
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
  late List<dynamic> roles;
  late List<dynamic> users = [];
  final formKey = GlobalKey<FormState>();
  bool isLoading = true;

  initRoles() async {
    roles = await RolesRequestManager.getRolesList(search: "");
    if (!roles.isEmpty) {
      setState(() {
        selectedValue = roles[0]["id"];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initRoles();
  }

  _setRole(int value) {
    setState(() {
      selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: CupertinoColors.white),
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
                  isLoading
                      ? kPlaceholder
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 19),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: kPrimaryColor, width: 2),
                              borderRadius: BorderRadius.circular(7)),
                          child: DropdownButton(
                              elevation: 0,
                              dropdownColor: kSecondaryColor,
                              style: const TextStyle(
                                  color: kPrimaryColor, fontFamily: "Font1"),
                              borderRadius: BorderRadius.circular(10),
                              isExpanded: true,
                              value: selectedValue,
                              onTap: () {
                                setState(() {});
                              },
                              icon: const Icon(Icons.arrow_drop_down),
                              items: roles.map((value) {
                                return DropdownMenuItem(
                                  value: value["id"],
                                  child: Text(
                                    value["role"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            width > kMobileWidth ? 18 : 13,
                                        fontFamily: "Font1"),
                                  ),
                                );
                              }).toList(),
                              onChanged: (dynamic newVal) {
                                setState(() {
                                  selectedValue = newVal;
                                });
                                // widget.setter!(int.parse(newVal));
                              }),
                        ),
                  const SizedBox(
                    height: 8,
                  ),
                  MyActionButton(
                    label: "Ajouter",
                    icon: Icons.add,
                    isLoading: isLoading,
                    color: kPrimaryColor,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
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
                            isLoading = false;
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
    );
  }
}

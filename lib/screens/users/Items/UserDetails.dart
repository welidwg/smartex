import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/Api/roles/RolesRequestManager.dart';
import 'package:smartex/Api/users/UsersRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomDropdown.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Loading.dart';
import 'package:smartex/components/Modals/ModalManager.dart';
import 'package:smartex/components/ResponsiveManager.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/users/Items/history/UserHistoryScreen.dart';
import 'package:smartex/storage/LocalStorage.dart';

class UserDetails extends StatefulWidget {
  Map<String, dynamic> user = {};
  late Function? updateView;

  UserDetails({super.key, required this.user, this.updateView});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late int selectedRole;
  late List<dynamic> roles;
  TextEditingController username = TextEditingController();
  TextEditingController newPass = TextEditingController();
  UsersRequestManager manager = UsersRequestManager();
  bool isLoading = true;
  bool isPassword = true;

  initRoles() async {
    roles = await RolesRequestManager.getRolesList(search: "");
    if (!roles.isEmpty) {
      setState(() {
        selectedRole = widget.user["role"]["id"];
        isLoading = false;
        isPassword = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initRoles();
    username = TextEditingController(text: widget.user["username"]);
  }

  _setRole(int value) {
    setState(() {
      selectedRole = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              color: kPrimaryColor,
            ),
            Text(
              widget.user['username'],
              style: kTitleTextStyle(
                  customFontSize: ResponsiveManager.setFont(context)),
            )
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        Input(
            label: "Nom d'utilisateur",
            is_Password: false,
            controller: username,
            onChange: (value) {}),
        const SizedBox(
          height: 8,
        ),
        Input(
            label: "Nouveau Mot de passe",
            is_Password: isPassword,
            controller: newPass,
            suffixIc: GestureDetector(
              child: Icon(isPassword
                  ? CupertinoIcons.eye_fill
                  : CupertinoIcons.eye_slash_fill),
              onTap: () {
                setState(() {
                  isPassword = !isPassword;
                });
              },
            ),
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
                style: TextStyle(fontSize: width > kMobileWidth ? 18 : 13),
              ),
            ),
            isLoading
                ? kPlaceholder
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 19),
                    decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(7)),
                    child: DropdownButton(
                        underline: Container(),
                        elevation: 0,
                        dropdownColor: kSecondaryColor,
                        style: const TextStyle(
                            color: kPrimaryColor, fontFamily: "Font1"),
                        borderRadius: BorderRadius.circular(10),
                        isExpanded: true,
                        value: selectedRole,
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
                                  fontSize: width > kMobileWidth ? 18 : 13,
                                  fontFamily: "Font1"),
                            ),
                          );
                        }).toList(),
                        onChanged: (dynamic newVal) {
                          setState(() {
                            selectedRole = newVal;
                          });
                          // widget.setter!(int.parse(newVal));
                        }),
                  ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? Center(child: LoadingComponent())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: MyActionButton(
                        isLoading: isLoading,
                        label: "",
                        color: kPrimaryColor,
                        icon: Icons.save_as,
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await _saveUserData(context);
                        },
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      MyActionButton(
                        isLoading: isLoading,
                        label: "",
                        color: kPrimaryColor,
                        icon: Icons.history,
                        onPressed: () async {
                          ModalManager.showModal(
                              content:  UserHistoryScreen(user: widget.user),
                              context: context);
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MyActionButton(
                        label: "",
                        isLoading: isLoading,
                        color: Colors.pink,
                        icon: Icons.delete_sweep,
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await _deleteUser(context);
                        },
                      )
                    ],
                  )
          ],
        )
      ],
    );
  }

  _deleteUser(BuildContext context) async {
    Map<String, dynamic> data = {
      "id": widget.user["id"],
    };
    var res = await manager.deleteUser(data);
    if (res['type'] == "success") {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res['message'])));
      widget.updateView!();
      setState(() {
        isLoading = false;
      });
    } else {
      print(res['message']);
    }
  }

  _saveUserData(BuildContext context) async {
    Map<String, dynamic> data = {
      "id": widget.user["id"],
      "username": username.text,
      "newPass": newPass.text,
      "role": selectedRole
    };
    var res = await manager.editUser(data);
    if (res['type'] == "success") {
      var current = await LocalStorage.getUser();
      if (current["id"] == res["user"]["id"]) {
        await LocalStorage.storage
            .write(key: 'user', value: json.encode(res["user"]));
      }
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res['message'])));
        widget.updateView!();
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res['message'])));
      }
      print(res['message']);
    }
    setState(() {
      isLoading = false;
    });
  }
}

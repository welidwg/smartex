import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smartex/Api/users/UsersRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/Cards/Card.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Loading.dart';
import 'package:smartex/components/Modals/BlurredModal.dart';
import 'package:smartex/components/Titles/HeadLine.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/users/Items/AddUserForm.dart';
import 'package:smartex/screens/users/Items/UserCard.dart';

class UsersScreen extends StatefulWidget {
  double? width;

  UsersScreen({super.key, this.width});

  static const String id = "users_screen";

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late List<dynamic> users = [];
  UsersRequestManager manager = UsersRequestManager();
  String search = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initUsers();
  }

  initUsers() async {
    users = await manager.getUsersList(search: search);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeadLine(
                title: "Liste des utilisateurs",
                fontS: widget.width! > kMobileWidth
                    ? kTabletFont
                    : kMobileTitleFont - 2,
                icon: Icons.supervised_user_circle_outlined,
                color: kPrimaryColor,
              ),
              FloatingActionButton(
                heroTag: "addUserTag",
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      isDismissible: false,
                      builder: ((context) {
                        return Builder(builder: (BuildContext ct) {
                          return AddUserForm(
                            context: ct,
                            updateView: initUsers,
                          );
                        });
                      }));
                },
                elevation: 0,
                backgroundColor: kPrimaryColor.withOpacity(1),
                child: const Icon(
                  Icons.add,
                  color: kSecondaryColor,
                ),
              ),
            ],
          ),
          const CustomSpacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: widget.width! > kMobileWidth
                    ? widget.width! / 2
                    : widget.width! - 90,
                child: Input(
                    vPadding: 15,
                    hPadding: 10,
                    label: "Recherche",
                    is_Password: false,
                    suffixIc: isLoading
                        ? LoadingComponent()
                        : const Icon(Icons.search),
                    onChange: (value) {
                      Future.delayed(const Duration(milliseconds: 1500), () {
                        setState(() {
                          search = value;
                          isLoading = true;
                        });
                        initUsers();
                      });
                    }),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: CupertinoColors.white,
              boxShadow: const [
                BoxShadow(
                  color: kSecondaryColor,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(1, 1),
                ),
              ],
            ),
            child: users.isEmpty
                ? SizedBox(
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const[
                         Center(child: Text("Aucun utilisateur trouvé")),
                      ],
                    ))
                : ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 16),
                    children: users.map((e) {
                      return UserCard(
                        user: e,
                        updateView: initUsers,
                      );
                    }).toList()),
          ))
        ],
      ),
    );
  }
}

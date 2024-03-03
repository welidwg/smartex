import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/Cards/Card.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("the width is : ${widget.width!}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
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
                      builder: ((context) {
                        return AddUserForm();
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
                    suffixIc: const Icon(Icons.search,color: kPrimaryColor,),
                    onChange: (value) {}),
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
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 16),
              children: const [
                UserCard(),
                UserCard(),
                UserCard(),
                UserCard(),
                UserCard(),
                UserCard(),
                UserCard(),
                UserCard(),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

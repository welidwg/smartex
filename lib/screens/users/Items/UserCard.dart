import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartex/components/Cards/Card.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/users/Items/UserDetails.dart';

class UserCard extends StatefulWidget {
  late Map<String, dynamic> user = {};
  late  Function? updateView;

  UserCard({super.key, required this.user,this.updateView});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: ((context) {
                return ModalContent(
                    content: UserDetails(
                  user: widget.user,
                      updateView: widget.updateView,
                ));
              }),
              isScrollControlled: true);
        },
        child: CustomCard(
          width: width > kMobileWidth ? width / 2 : width,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: kSecondaryColor.withOpacity(0.8),
                    child: const Icon(
                      FontAwesomeIcons.user,
                      color: kPrimaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user["username"],
                        style: kContentTextStyle(customFontSize: kMobileFont)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.user["role"] == 0
                            ? "Administrateur"
                            : "Technicien",
                        style: kContentTextStyle(customFontSize: 14).copyWith(
                            fontWeight: FontWeight.normal, color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios_sharp)
            ],
          ),
        ),
      ),
    );
  }
}

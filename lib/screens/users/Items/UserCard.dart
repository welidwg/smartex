import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Cards/Card.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/users/Items/UserDetails.dart';

class UserCard extends StatefulWidget {
  const UserCard({super.key});

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
                return const ModalContent(content: UserDetails());
              }),
            isScrollControlled: true
          );
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
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Username",
                        style: kContentTextStyle(customFontSize: kMobileFont)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Administrateur",
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

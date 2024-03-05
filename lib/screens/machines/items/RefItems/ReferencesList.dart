import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/machines/items/MachineCard.dart';
import 'package:smartex/screens/machines/items/RefItems/AllRefs.dart';

class ReferencesList extends StatelessWidget {
  const ReferencesList({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.text_snippet,
                    color: kPrimaryColor,
                  ),
                  Text(
                    "Réferences",
                    style: kTitleTextStyle(
                        customFontSize: width > kMobileWidth
                            ? kTabletFont - 2
                            : kMobileFont + 1),
                  )
                ],
              ),
              SizedBox(
                width: width / 3,
                child: Input(
                    vPadding: 0,
                    hPadding: 7,
                    label: "Références",
                    is_Password: false,
                    onChange: (value) {}),
              ),
            ],
          ),
        ),
        const CustomSpacer(),
        Container(
          height: 80,
          width: width,
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
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            //padding: EdgeInsets.only(bottom: 16),
            children: const [
              MachineCard(
                type: "re",
              ),
              MachineCard(
                type: "re",
              ),
              MachineCard(
                type: "re",
              ),
              MachineCard(
                type: "re",
              ),
              MachineCard(
                type: "re",
              ),
              MachineCard(
                type: "re",
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return const ModalContent(
                            content: AllReferenceScreen());
                      });
                },
                child: const Text(
                  "Afficher tous",
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
              ),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
        )
      ],
    );
  }
}

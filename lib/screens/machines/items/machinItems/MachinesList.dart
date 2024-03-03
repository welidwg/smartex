import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/machines/items/MachineCard.dart';

class MachinesList extends StatelessWidget {
  const MachinesList({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return  Column(
      children: [
        CustomSpacer(),
        Container(
          margin: EdgeInsets.only(left: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.gear_alt_fill,
                    color: kPrimaryColor,
                  ),
                  Text(
                    "Machines en stock",
                    style: kTitleTextStyle(
                        customFontSize: width > kMobileWidth
                            ? kTabletFont -2
                            : kMobileFont + 1),
                  )
                ],
              ),
              SizedBox(
                width: width / 3,
                child: Input(
                    vPadding: 0,
                    hPadding: 7,
                    suffixIc: GestureDetector(child:const Icon(Icons.qr_code_scanner_sharp,size: 20,),onTap: (){
                      print("scan");
                    },),
                    label: "Code",
                    is_Password: false,
                    onChange: (value) {}),
              ),
            ],
          ),
        ),
        CustomSpacer(),
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
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            //padding: EdgeInsets.only(bottom: 16),
            children: const [
              MachineCard(type: "ma",),
              MachineCard(type: "ma",),
              MachineCard(type: "ma",),
              MachineCard(type: "ma",),
              MachineCard(type: "ma",),

            ],
          ),
        ),  const SizedBox(
          height: 8,
        ),

        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Afficher tous",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
        )
      ],
    );
  }
}

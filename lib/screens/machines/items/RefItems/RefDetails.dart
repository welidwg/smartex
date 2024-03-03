import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/constants.dart';

class RefDetails extends StatelessWidget {
  const RefDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.asterisk,
              color: kPrimaryColor,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Référence : PPFUL2",
              style: kTitleTextStyle(
                  customFontSize:
                      width > kMobileWidth ? kTabletFont - 2 : kMobileFont),
            )
          ],
        ),
        CustomSpacer(),
        Input(label: "Référence", is_Password: false, onChange: (value) {},value: "PPFUL2",),
        SizedBox(
          height: 13,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              FontAwesomeIcons.solidEye,
              size: 15,
              weight: 10,
              color: kPrimaryColor,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
                    "Voir les machines liées à cette référence",style: TextStyle(color: kPrimaryColor),))
          ],
        ),
        CustomSpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: MyActionButton(
                  label: "",
                  color: kPrimaryColor,
                  icon: Icons.save_as,
                )),
            const SizedBox(
              width: 10,
            ),
            MyActionButton(
              label: "",
              color: Colors.pink,
              icon: Icons.delete_sweep,
            )
          ],
        )
      ],
    );
    ;
  }
}

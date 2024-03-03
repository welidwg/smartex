import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/constants.dart';

class AddRefForm extends StatelessWidget {
  const AddRefForm({super.key});


  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.asterisk,
              color: kPrimaryColor,
              size: 20,
            ),
            SizedBox(width: 10,),
            Text(
              "Ajouter des référence",
              style: kTitleTextStyle(
                  customFontSize:
                  width > kMobileWidth ? kTabletFont - 2 : kMobileFont),
            )
          ],
        ),
        CustomSpacer(),
        Input(label: "Référence", is_Password: false, onChange: (value){}),
        SizedBox(height: 13,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:const [
            Icon(FontAwesomeIcons.infoCircle,size: 15,weight: 10,color: kPrimaryColor,),
            SizedBox(width: 8,),
            Expanded(child: Text("Vous pouvez ajouter plusieurs références en les séparant par des virgules (ref1,ref2...)"))
          ],
        ),
        CustomSpacer(),
        MyActionButton(label: "Ajouter", color: kPrimaryColor)
      ],
    );
  }
}

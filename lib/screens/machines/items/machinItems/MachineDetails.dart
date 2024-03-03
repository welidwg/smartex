import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomDropdown.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/constants.dart';
class MachineDetails extends StatefulWidget {
  const MachineDetails({super.key});

  @override
  State<MachineDetails> createState() => _MachineDetailsState();
}

class _MachineDetailsState extends State<MachineDetails> {


@override
  Widget build(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.gear_solid,
              color: kPrimaryColor,
              size: 20,
            ),
            SizedBox(width: 10,),
            Text(
              "Machine : #65278",
              style: kTitleTextStyle(
                  customFontSize:
                  width > kMobileWidth ? kTabletFont - 2 : kMobileFont),
            )
          ],
        ),

        SizedBox(height: 8,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Modifier la référence",textAlign: TextAlign.start,),
            SizedBox(height: 10,),
            CustomDropdown(items: ["ref1","ref3","ref2"], defaultItem: "ref2"),
          ],
        ),
        SizedBox(height: 8,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const Text("Modifier le code",textAlign: TextAlign.start,),
            const SizedBox(height: 10,),
            Input(label: "Code", is_Password: false, onChange: (value){},vPadding: 17,value: "65278",),
          ],
        ),
        const SizedBox(height: 8,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Modifier l'état",textAlign: TextAlign.start,),
            SizedBox(height: 10,),
            CustomDropdown(items: ["En panne","En marche"], defaultItem: "En marche"),
          ],
        ), const SizedBox(height: 8,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Modifier la chaîne",textAlign: TextAlign.start,),
            SizedBox(height: 10,),
            CustomDropdown(items: ["CH1","CH2","CH17"], defaultItem: "CH17"),
          ],
        ),
        const SizedBox(height: 8,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Modifier le parc",textAlign: TextAlign.start,),
            SizedBox(height: 10,),
            CustomDropdown(items: ["Parc stock","Parc occupée"], defaultItem: "Parc stock"),
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
    );;
  }
}

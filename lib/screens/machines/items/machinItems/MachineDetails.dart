import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomDropdown.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/machines/items/machinItems/History.dart';

class MachineDetails extends StatefulWidget {
  const MachineDetails({super.key});

  @override
  State<MachineDetails> createState() => _MachineDetailsState();
}

class _MachineDetailsState extends State<MachineDetails> {
  late TextEditingController codeCtrl;
  late Map<int, dynamic> chaines={};
  late Map<int, dynamic> parcs={};
  late Map<int, dynamic> refs={};
  late Map<int, dynamic> etats={};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeCtrl = TextEditingController(text: "65278");
    chaines[0] = "CH17";
    chaines[1] = "CH18";
    chaines[2] = "CH19";
    refs[0] = "REF1";
    refs[1] = "REF2";
    refs[2] = "REF3";
    parcs[0] = "Parc stock";
    parcs[1] = "Parc occupé";
    etats[0] = "En marche";
    etats[1] = "En panne";
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
              CupertinoIcons.gear_solid,
              color: kPrimaryColor,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Machine : #65278",
              style: kTitleTextStyle(
                  customFontSize:
                      width > kMobileWidth ? kTabletFont - 2 : kMobileFont),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Modifier la référence",
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDropdown(items: refs, defaultItem: 0),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Modifier le code",
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 10,
            ),
            Input(
              label: "Code",
              is_Password: false,
              onChange: (value) {},
              vPadding: 17,
              controller: codeCtrl,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Modifier l'état",
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDropdown(items: etats, defaultItem: 0),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Modifier la chaîne",
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDropdown(items: chaines, defaultItem: 0),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Modifier le parc",
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDropdown(items: parcs, defaultItem: 0),
          ],
        ),
        const CustomSpacer(),
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
              icon: Icons.manage_history,
              onPressed: () {
                //Navigator.pop(context);
                showModalBottomSheet(
                    isScrollControlled: true,
                    enableDrag: true,
                    context: context,
                    builder: (context) {
                      return const ModalContent(content: HistoryMachine());
                    });
              },
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

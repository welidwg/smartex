import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomDropdown.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/ai/CameraScreen.dart';

class AddMachineForm extends StatefulWidget {
  const AddMachineForm({super.key});

  @override
  State<AddMachineForm> createState() => _AddMachineFormState();
}

class _AddMachineFormState extends State<AddMachineForm> {
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
              "Ajouter une machine",
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
          children: const [
            Text(
              "Choisissez la référence",
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 10,
            ),
            CustomDropdown(
                items: ["ref1", "ref3", "ref2"], defaultItem: "ref2"),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Saisissez le code",
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
                suffixIc: GestureDetector(
                  onTap: () async{
                    // showModalBottomSheet(
                    //     backgroundColor: Colors.transparent,
                    //     context: context,
                    //     builder: ((context) {
                    //       return const ModalContent(content: CameraScreen());
                    //     }),
                    //     isScrollControlled: true
                    // );

                    //Navigator.pushReplacementNamed(context, CameraScreen.id);
                    await _openCameraScreen(context);
                  },
                  child: Icon(Icons.qr_code_scanner_rounded),
                )),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Choisissez l'état",
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 10,
            ),
            CustomDropdown(
                items: ["En panne", "En marche"], defaultItem: "En marche"),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Choisissez la chaîne",
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 10,
            ),
            CustomDropdown(items: ["CH1", "CH2", "CH17"], defaultItem: "CH17"),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Choisissez le parc",
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 10,
            ),
            CustomDropdown(
                items: ["Parc stock", "Parc occupée"],
                defaultItem: "Parc stock"),
          ],
        ),
        CustomSpacer(),
        MyActionButton(label: "Ajouter", color: kPrimaryColor)
      ],
    );
    ;
  }
  Future<void> _openCameraScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraScreen()),
    );
  }
}

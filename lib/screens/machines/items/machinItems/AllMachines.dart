import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Title.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/ai/CameraScreen.dart';
import 'package:smartex/screens/machines/items/MachineCard.dart';

class AllMachineScreen extends StatefulWidget {
  const AllMachineScreen({super.key});

  @override
  State<AllMachineScreen> createState() => _AllMachineScreenState();
}

class _AllMachineScreenState extends State<AllMachineScreen> {
  late TextEditingController codeCtrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeCtrl = TextEditingController(text: "");
  }

  Future<void> _openCameraScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CameraScreen(
                setter: _setCode,
              )),
    );
  }

  void _setCode(String value) {
    setState(() {
      codeCtrl = TextEditingController(text: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Column(
          children: [
            const TitleComponent(
                title: "Tous les machines", icon: CupertinoIcons.gear_solid),
            CustomSpacer(),
            Input(
                controller: codeCtrl,
                vPadding: 0,
                hPadding: 7,
                suffixIc: GestureDetector(
                  child: const Icon(
                    Icons.qr_code_scanner_sharp,
                    size: 20,
                  ),
                  onTap: () {
                    _openCameraScreen(context);
                  },
                ),
                label: "Code",
                is_Password: false,
                onChange: (value) {}),
            CustomSpacer(),
            Container(
              height: 300,
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
                scrollDirection: Axis.vertical,
                //padding: EdgeInsets.only(bottom: 16),
                children: const [
                  MachineCard(
                    type: "ma",
                  ),
                  MachineCard(
                    type: "ma",
                  ),
                  MachineCard(
                    type: "ma",
                  ),
                  MachineCard(
                    type: "ma",
                  ),
                  MachineCard(
                    type: "ma",
                  ),
                  MachineCard(
                    type: "ma",
                  ),
                  MachineCard(
                    type: "ma",
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

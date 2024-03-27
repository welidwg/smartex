import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/Api/machines/MachinesRequestManager.dart';
import 'package:smartex/Api/references/ReferencesRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/Cards/Card.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Loading.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/components/Placeholders/ListPlaceHolder.dart';
import 'package:smartex/components/Titles/HeadLine.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/machines/items/MachineCard.dart';
import 'package:smartex/screens/machines/items/machinItems/MachinesList.dart';
import 'package:smartex/screens/machines/items/RefItems/ReferencesList.dart';
import 'package:smartex/screens/machines/items/forms/AddMachineForm.dart';
import 'package:smartex/screens/machines/items/forms/AddRefForm.dart';

class MachinesScreen extends StatefulWidget {
  const MachinesScreen({super.key});

  static const String id = "machines_screen";

  @override
  State<MachinesScreen> createState() => _MachinesScreenState();
}

class _MachinesScreenState extends State<MachinesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              HeadLine(
                title: "Machines et références",
                fontS:
                    width > kMobileWidth ? kTabletFont + 3 : kMobileTitleFont,
                icon: CupertinoIcons.gear_solid,
                color: kPrimaryColor,
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                const ReferencesList(),
                const CustomSpacer(),
                MachinesList(
                  updateView: () {
                    print("update from machien screen");
                  },
                ),
              ],
            ),
          ],
        ));
  }
}

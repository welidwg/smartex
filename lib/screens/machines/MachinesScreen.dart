import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/Cards/Card.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
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
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              HeadLine(
                title: "Liste des machines",
                fontS:
                    width > kMobileWidth ? kTabletFont : kMobileTitleFont - 2,
                icon: Icons.supervised_user_circle_outlined,
                color: kPrimaryColor,
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MyActionButton(
                    onPressed: (){
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: ((context) {
                            return const ModalContent(content: AddRefForm());
                          }),
                          isScrollControlled: true
                      );
                    },
                    label: "Référence",
                    color: kPrimaryColor,
                    icon: CupertinoIcons.plus,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: MyActionButton(
                    label: "Machine",
                    color: kPrimaryColor,
                    icon: CupertinoIcons.plus,
                    onPressed: (){
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: ((context) {
                            return const ModalContent(content: AddMachineForm());
                          }),
                          isScrollControlled: true
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width > kMobileWidth ? width / 2 : width - 90,
                  child: Input(
                    vPadding: 0,
                      label: "Recherche",
                      is_Password: false,
                      suffixIc: GestureDetector(child: const Icon(Icons.search)),
                      onChange: (value) {}),
                ),
              ],
            ),
            const CustomSpacer(),
            const ReferencesList(),
            const MachinesList()


          ],
        ));
  }
}

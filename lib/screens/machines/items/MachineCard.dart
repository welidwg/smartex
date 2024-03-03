import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Cards/Card.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/machines/items/RefItems/RefDetails.dart';
import 'package:smartex/screens/machines/items/machinItems/MachineDetails.dart';

class MachineCard extends StatefulWidget {
  final String type;

  const MachineCard({super.key, required this.type});

  @override
  State<MachineCard> createState() => _MachineCardState();
}

class _MachineCardState extends State<MachineCard> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: ((context) {
                return ModalContent(
                    content:
                        widget.type == "re" ? const RefDetails() : const MachineDetails());
              }),
              isScrollControlled: true);
        },
        child: CustomCard(
          padding: 10,
          width: width > kMobileWidth ? width / 7 : width * 0.6,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.type == "ma" ? "Code/Chaîne":"Référence",
                    style: kContentTextStyle(customFontSize: kMobileFont)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios_sharp)
            ],
          ),
        ),
      ),
    );
  }
}

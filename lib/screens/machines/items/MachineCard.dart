import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Cards/Card.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/machines/items/RefItems/RefDetails.dart';
import 'package:smartex/screens/machines/items/machinItems/MachineDetails.dart';

class MachineCard extends StatefulWidget {
  final String type;
  late Map<String, dynamic> item = {};
  late Function updateView;

  MachineCard(
      {super.key,
      required this.type,
      required this.item,
      required this.updateView});

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
                    content: widget.type == "re"
                        ? RefDetails(
                            ref: widget.item,
                            updateView: widget.updateView,
                          )
                        :  MachineDetails(updateView:widget.updateView,machine: widget.item,));
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.type == "re"
                            ? widget.item["ref"]
                            : "${widget.item["reference"]["ref"]}#${widget.item["code"]} / ${widget.item["chaine"]["libelle"]}",
                        style: kContentTextStyle(customFontSize: kMobileFont)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      widget.type=="ma" ? Text("${widget.item["etat"]["libelle"]}") : Container()
                    ],
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

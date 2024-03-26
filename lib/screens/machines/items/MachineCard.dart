import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Cards/Card.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/components/Modals/ModalManager.dart';
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
  bool isActiveExchange = false;

  checkActiveExchange() {
    if (widget.type == "ma") {
      setState(() {
        isActiveExchange =
            widget.item["echanges"].any((echange) => echange['isActive'] == 1);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkActiveExchange();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          ModalManager.showModal(
              content: widget.type == "re"
                  ? RefDetails(
                      ref: widget.item,
                      updateView: widget.updateView,
                    )
                  : MachineDetails(
                      updateView: widget.updateView,
                      machine: widget.item,
                    ),
              context: context);
        },
        child: CustomCard(
          padding: 10,
          width: width > kMobileWidth ? width / 5 : width * 0.6,
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
                            : "${widget.item["code"]} / ${widget.item["chaine"]["libelle"]}",
                        style: kContentTextStyle(
                                customFontSize: width > kMobileWidth
                                    ? kTabletFont
                                    : kMobileFont)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      // widget.type == "ma"
                      //     ? Text(
                      //         "${widget.item["etat"]["libelle"]}",
                      //         style: TextStyle(
                      //             fontSize: width > kMobileWidth
                      //                 ? kTabletFont - 3
                      //                 : kMobileFont),
                      //       )
                      //     : Container(),
                      isActiveExchange ? Text("En échange") : SizedBox()
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

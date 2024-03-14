import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Modals/ModalManager.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/machines/items/forms/AddHistoryForm.dart';
import 'package:smartex/screens/machines/items/machinItems/HistoryCard.dart';

class HistoryMachine extends StatefulWidget {
  Map<String, dynamic> machine;
  late Function updateView;

  HistoryMachine({super.key, required this.machine, required this.updateView});

  @override
  State<HistoryMachine> createState() => _HistoryMachineState();
}

class _HistoryMachineState extends State<HistoryMachine> {
  late Map<String, dynamic> ma;

  initHistory() {
    setState(() {
      ma = widget.machine;
    });
    widget.updateView();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initHistory();
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
            const SizedBox(
              width: 10,
            ),
            Text(
              "Historique du Machine : #${widget.machine["code"]} ",
              style: kTitleTextStyle(
                  customFontSize:
                      width > kMobileWidth ? kTabletFont - 2 : kMobileFont),
            )
          ],
        ),
        const CustomSpacer(),
        SizedBox(
          height: 420,
          child: ListView(
              children: widget.machine["historique"].length == 0
                  ? [const Center(child: Text("Aucun historique"))]
                  : widget.machine["historique"].map<Widget>((e) {
                      return HistoryCard(
                        history: e,
                      );
                    }).toList()),
        ),
        const CustomSpacer(),
        MyActionButton(
          label: "Ajouter",
          color: kPrimaryColor,
          onPressed: () {
            ModalManager.showModal(
                content: AddHistoryForm(
                    idMachine: widget.machine["id"], updateView: initHistory),
                context: context);
          },
        ),
      ],
    );
  }
}

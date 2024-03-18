import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartex/Api/history/HistoryRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Modals/ModalManager.dart';
import 'package:smartex/components/ResponsiveManager.dart';
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
  late Map<String, dynamic> estimations = {};
  late String predDate = "";
  late String predHour = "";

  initHistory() async {
    setState(() {
      ma = widget.machine;
    });
    widget.updateView();
    estimations =
        await HistoryRequestManager.getEstimation({"id_machine": ma["id"]});
    if (estimations.isNotEmpty) {
      setState(() {
        predDate = DateFormat('dd/MM/yyyy')
            .format(DateTime.parse(estimations["estimated"]));
        predHour = DateFormat('HH:mm')
            .format(DateTime.parse(estimations["estimated"]));
      });
    }
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
        SizedBox(
          height: 10,
        ),
        estimations.isNotEmpty
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Taux de panne moyen :",
                          style: TextStyle(
                              fontSize: ResponsiveManager.setFont(context) - 1,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("${estimations["avg"]}",
                            style: TextStyle(
                                fontSize:
                                    ResponsiveManager.setFont(context) - 1))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Date de panne prochain estimé : ",
                          style: TextStyle(
                              fontSize: ResponsiveManager.setFont(context) - 1,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month_rounded,
                                  size: 15,
                                  color: kPrimaryColor,
                                ),
                                Text(predDate,
                                    style: TextStyle(
                                        fontSize:
                                            ResponsiveManager.setFont(context) -
                                                2,
                                        color: kPrimaryColor)),
                              ],
                            ),
                            SizedBox(width: 10,),
                            Row(
                              children: [
                                const Icon(
                                  Icons.lock_clock,
                                  size: 15,
                                  color: kPrimaryColor,
                                ),
                                Text(predHour,
                                    style: TextStyle(
                                        fontSize:
                                            ResponsiveManager.setFont(context) -
                                                2,
                                        color: kPrimaryColor)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : SizedBox(),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 420,
          child: Scrollbar(
            thumbVisibility: true,
            interactive: true,
            child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: widget.machine["historique"].length == 0
                    ? [const Center(child: Text("Aucun historique"))]
                    : widget.machine["historique"].map<Widget>((e) {
                        return HistoryCard(
                          history: e,
                        );
                      }).toList()),
          ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartex/Api/history/HistoryRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/Cards/SecondaryCard.dart';
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
  DateTime aujourdhui = DateTime.now();
  late DateTime targetDate;
  ScrollController scrollController = ScrollController();
  bool isReversed = false;

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
        targetDate = DateTime.parse(estimations["estimated"]);
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
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration:
          BoxDecoration(
            color: kSecondaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 420,
                child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  interactive: false,
                  child: ListView.builder(
                      controller: scrollController,
                      reverse: isReversed,
                      itemBuilder: (context, index) {
                        if (widget.machine["historique"].length == 0) {
                          return const Center(child: Text("Aucun historique"));
                        } else {
                          return HistoryCard(
                            history: widget.machine["historique"][index],
                          );
                        }
                      },
                      itemCount: widget.machine["historique"].length,
                      physics: const BouncingScrollPhysics()),
                ),
              ),
              FloatingActionButton(
                mini: true,
                backgroundColor: kPrimaryColor,
                onPressed: () {
                  setState(() {
                    isReversed = !isReversed;
                  });
                },
                child: Icon(isReversed
                    ? Icons.arrow_drop_up_sharp
                    : Icons.arrow_drop_down),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
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
                          "Date de panne prochain estimé ${targetDate.isBefore(aujourdhui) ?'(Déjà passé)':'(Dans ${targetDate.difference(aujourdhui).inDays} jours)'} :",
                          style: TextStyle(
                              fontSize: ResponsiveManager.setFont(context) - 1,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SecondaryCard(
                              content: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month_rounded,
                                    size: 15,
                                    color: kPrimaryColor,
                                  ),
                                  Text(predDate,
                                      style: TextStyle(
                                          fontSize: ResponsiveManager.setFont(
                                                  context) -
                                              2,
                                          color: kPrimaryColor)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SecondaryCard(
                              content: Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_filled_outlined,
                                    size: 15,
                                    color: kPrimaryColor,
                                  ),
                                  Text(predHour,
                                      style: TextStyle(
                                          fontSize: ResponsiveManager.setFont(
                                                  context) -
                                              2,
                                          color: kPrimaryColor)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : SizedBox(),
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

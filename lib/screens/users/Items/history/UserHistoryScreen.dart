import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartex/components/Cards/Card.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/ResponsiveManager.dart';
import 'package:smartex/components/Titles/HeadLine.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/storage/LocalStorage.dart';

class UserHistoryScreen extends StatefulWidget {
  late Map<String, dynamic> user = {};

  UserHistoryScreen({super.key, required this.user});

  @override
  State<UserHistoryScreen> createState() => _UserHistoryScreenState();
}

class _UserHistoryScreenState extends State<UserHistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadLine(
          title: "Historique d'activité du ${widget.user["username"]}",
          fontS: ResponsiveManager.setFont(context),
          color: kPrimaryColor,
          icon: Icons.history,
        ),
        CustomSpacer(),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kSecondaryColor.withOpacity(0.2),
          ),
          child: widget.user["activities"].length == 0
              ? Center(child: Text("Aucun activité trouvé"))
              : Scrollbar(
                  thickness: 1,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        child: CustomCard(
                            content: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.manage_history_outlined,
                                  color: kPrimaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${widget.user["activities"][index]["activite"]}",
                                              style: TextStyle(
                                                  fontSize:
                                                      ResponsiveManager.setFont(
                                                              context) -
                                                          1,
                                                  fontWeight: FontWeight.bold,
                                                  color: kPrimaryColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                      widget.user["activities"][index]
                                                  ["id_machine"] !=
                                              null
                                          ? Row(
                                              children: [
                                                Text(
                                                  "Machine :",
                                                  style: TextStyle(
                                                      fontSize:
                                                          ResponsiveManager
                                                                  .setFont(
                                                                      context) -
                                                              2,
                                                      color: kPrimaryColor),
                                                ),
                                                Text(
                                                  "${widget.user["activities"][index]["machine"]["code"]} / ${widget.user["activities"][index]["machine"]["chaine"]["libelle"]}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          ResponsiveManager
                                                                  .setFont(
                                                                      context) -
                                                              2,
                                                      color: kPrimaryColor),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        DateFormat("dd/MM/yyyy - HH:mm a")
                                            .format(DateTime.parse(
                                                widget.user["activities"][index]
                                                    ["created_at"])),
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: ResponsiveManager.setFont(
                                                    context) -
                                                3,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                      );
                    },
                    itemCount: widget.user["activities"].length,
                  ),
                ),
        )
      ],
    );
  }
}

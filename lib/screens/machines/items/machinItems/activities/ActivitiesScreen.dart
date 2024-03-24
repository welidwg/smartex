import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartex/components/Cards/Card.dart';
import 'package:smartex/components/ResponsiveManager.dart';
import 'package:smartex/components/Titles/HeadLine.dart';
import 'package:smartex/constants.dart';

class MachineActivitiesScreen extends StatefulWidget {
   List activities;
   MachineActivitiesScreen({super.key,required this.activities});

  @override
  State<MachineActivitiesScreen> createState() => _MachineActivitiesScreenState();
}

class _MachineActivitiesScreenState extends State<MachineActivitiesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.activities[0].length);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadLine(title: "Activités des utilisateurs", fontS: ResponsiveManager.setFont(context), color: kPrimaryColor,icon:  CupertinoIcons
            .person_crop_circle_fill_badge_checkmark,),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kSecondaryColor.withOpacity(0.2),
          ),
          child: widget.activities[0].length == 0
              ? const Center(child: Text("Aucun activité trouvé"))
              : Scrollbar(
            thickness: 1,
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8),
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
                                        Text(
                                          "${widget.activities[index]["activite"]}",
                                          style: TextStyle(
                                              fontSize:
                                              ResponsiveManager.setFont(
                                                  context) -
                                                  1,
                                              fontWeight: FontWeight.bold,
                                              color: kPrimaryColor),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Utilisateur :",
                                          style: TextStyle(
                                              fontSize:
                                              ResponsiveManager
                                                  .setFont(
                                                  context) -
                                                  2,
                                              color: kPrimaryColor),
                                        ),
                                        Text(
                                          "${widget.activities[index]["user"]["username"]}",
                                          style: TextStyle(
                                              fontSize:
                                              ResponsiveManager
                                                  .setFont(
                                                  context) -
                                                  2,
                                              color: kPrimaryColor),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      DateFormat("dd/MM/yyyy - HH:mm a")
                                          .format(DateTime.parse(
                                          widget.activities[index]
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
              itemCount: widget.activities.length,
            ),
          ),
        )
      ],
    );
  }
}

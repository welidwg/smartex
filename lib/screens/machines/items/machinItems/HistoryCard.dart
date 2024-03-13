import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartex/constants.dart';

class HistoryCard extends StatefulWidget {
  Map<String, dynamic> history;

  HistoryCard({super.key, required this.history});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.history["date_heure"]));
    String heure = DateFormat('HH:mm').format(DateTime.parse(widget.history["date_heure"]));


  return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundColor: kSecondaryColor,
              child: Icon(
                Icons.history,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(children: [
                        Icon(Icons.calendar_month_rounded,size: 13,color: kPrimaryColor),
                        Text("$date",style: TextStyle(fontWeight: FontWeight.bold,color: kPrimaryColor),),
                      ],),
                      SizedBox(width: 10,),
                      Row(children: [
                        Icon(Icons.access_time_filled,size: 13,color: kPrimaryColor),
                        Text("$heure",style: TextStyle(fontWeight: FontWeight.bold,color: kPrimaryColor),),

                      ],),
                    ],
                  ),

                  Text(widget.history["historique"])
                ],

              ),
            )
          ],
        ),
      ),
    );
  }
}

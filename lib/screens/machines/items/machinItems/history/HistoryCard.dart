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


  return Container(
    margin: EdgeInsets.all(10),
    constraints: BoxConstraints(minHeight: 80),
    decoration: BoxDecoration(
      color: kSecondaryColor.withOpacity(0.4),
      borderRadius: BorderRadius.circular(20)
    ),
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
                      const Icon(Icons.calendar_month_rounded,size: 13,color: kPrimaryColor),
                      Text(date,style: const TextStyle(fontWeight: FontWeight.bold,color: kPrimaryColor),),
                    ],),
                    const SizedBox(width: 10,),
                    Row(children: [
                      const Icon(Icons.access_time_filled,size: 13,color: kPrimaryColor),
                      Text(heure,style: const TextStyle(fontWeight: FontWeight.bold,color: kPrimaryColor),),

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

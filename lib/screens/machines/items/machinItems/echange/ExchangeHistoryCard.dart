import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartex/constants.dart';

class ExchangeHistoryCard extends StatefulWidget {
  Map<String, dynamic> history;

  ExchangeHistoryCard({super.key, required this.history});

  @override
  State<ExchangeHistoryCard> createState() => _ExchangeHistoryCardState();
}

class _ExchangeHistoryCardState extends State<ExchangeHistoryCard> {
  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.history["date_heure"]));
    String heure = DateFormat('HH:mm')
        .format(DateTime.parse(widget.history["date_heure"]));
    String dateFin = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.history["updated_at"]));
    String heureFin = DateFormat('HH:mm')
        .format(DateTime.parse(widget.history["updated_at"]).add(Duration(hours: 1)));
    return Container(
      margin: const EdgeInsets.all(10),
      constraints: const BoxConstraints(minHeight: 80),
      decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20)),
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
                  Text(
                    widget.history["chaine_to"]["libelle"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: kPrimaryColor),
                  ),
                  Row(
                    children: [
                      const Text("Début: "),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month_rounded,
                              size: 13, color: kPrimaryColor),
                          Text(
                            date,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.access_time_filled,
                              size: 13, color: kPrimaryColor),
                          Text(
                            heure,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  widget.history["isActive"] == 0
                      ? Row(
                          children: [
                            const Text("Fin: "),
                            Row(
                              children: [
                                const Icon(Icons.calendar_month_rounded,
                                    size: 13, color: kPrimaryColor),
                                Text(
                                  dateFin,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.access_time_filled,
                                    size: 13, color: kPrimaryColor),
                                Text(
                                  heureFin,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              "Active",
                              style:
                                  TextStyle(color: CupertinoColors.systemGreen),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

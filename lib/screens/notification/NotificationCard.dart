import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/notification/NotificationService.dart';

class NotificationCard extends StatefulWidget {
  NotificationCard({super.key, required this.notification});

  late Map<String, dynamic> notification;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(10),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  await NotificationService(redirect: (String route) {
                    Navigator.of(context).pushReplacementNamed(route);
                  }).showNotification(title: "Test", body: 'Test');
                },
                child: const CircleAvatar(
                  backgroundColor: kSecondaryColor,
                  child: Icon(
                    Icons.notifications_active_rounded,
                    color: kPrimaryColor,
                  ),
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
                        Row(
                          children: [
                            Text(
                              widget.notification["title"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(widget.notification["content"]),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            "${DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.notification["created_at"]))} - ${DateFormat("HH:mm").format(DateTime.parse(widget.notification["created_at"]))}",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/constants.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({super.key});

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
              const CircleAvatar(
                backgroundColor: kSecondaryColor,
                child: Icon(
                  Icons.notifications_active_rounded,
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
                        Row(
                          children: const [
                            Text(
                              "Titre",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry"),
                    const SizedBox(height: 7,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text("10/06/2024 - 10:00",
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

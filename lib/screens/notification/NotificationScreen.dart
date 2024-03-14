import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Titles/HeadLine.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/notification/NotificationCard.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              HeadLine(
                title: "Notifications",
                fontS: kMobileFont + 5,
                color: kPrimaryColor,
                icon: Icons.notifications_active_rounded,
              ),
            ],
          ),
          const CustomSpacer(),
          Expanded(
            child: SizedBox(
              child: ListView(children: const [
                NotificationCard(),
                NotificationCard(),
                NotificationCard(),
                NotificationCard(),
                NotificationCard(),
                NotificationCard(),
                NotificationCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

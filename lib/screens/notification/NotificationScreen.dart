import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/Api/notifications/NotificationRequestManager.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Placeholders/ListPlaceHolder.dart';
import 'package:smartex/components/Titles/HeadLine.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/notification/NotificationCard.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late List<dynamic> notifications = [];

  initNotif() async {
    notifications = await NotificationRequestManager.getNotification({});
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    initNotif();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
            child: notifications.isNotEmpty
                ? SizedBox(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction)async{
                           await _deleteNotif(context,notifications[index]["id"]);
                           setState(() {
                             notifications.removeAt(index);
                           });
                          },
                          child: NotificationCard(
                            notification: notifications[index],
                          ),
                        );
                      },
                      itemCount: notifications.length,
                      physics: const BouncingScrollPhysics(),
                    ),
                  )
                : ListPlaceholder(),
          ),
        ],
      ),
    );
  }
  _deleteNotif(BuildContext context,int id)async{
    var res=await NotificationRequestManager.delete(id);
    if (res["type"] == "success") {

    } else {
      print(res['message']);
    }

  }
}

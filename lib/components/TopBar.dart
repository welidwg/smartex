import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/constants.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration:  BoxDecoration(
        color: kSecondaryColor.withOpacity(0.4),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                  elevation: MaterialStateProperty.resolveWith((states) => 0),
                  foregroundColor: MaterialStateProperty.all(kPrimaryColor)),
              child: const Icon(
                Icons.menu_outlined,
                size: 27,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: kPrimaryColor,
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text(
                    "Username",
                    style: TextStyle(
                        fontSize: kMobileFont,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

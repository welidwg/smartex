import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/constants.dart';

class HistoryMachine extends StatefulWidget {
  const HistoryMachine({super.key});

  @override
  State<HistoryMachine> createState() => _HistoryMachineState();
}

class _HistoryMachineState extends State<HistoryMachine> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.gear_solid,
              color: kPrimaryColor,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Historique du Machine : #65278",
              style: kTitleTextStyle(
                  customFontSize:
                      width > kMobileWidth ? kTabletFont - 2 : kMobileFont),
            )
          ],
        ),
        CustomSpacer(),
        Container(
          height: 300,
          child: ListView(
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                      const  CircleAvatar(
                        backgroundColor: kSecondaryColor,
                        child: Icon(
                          Icons.history,
                          color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const[
                          Text("10/05/2017"),
                          Text("Panne")
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

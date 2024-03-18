import 'package:flutter/cupertino.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/ResponsiveManager.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/machines/items/machinItems/HistoryCard.dart';
import 'package:smartex/screens/machines/items/machinItems/echange/ExchangeHistoryCard.dart';

class HistoryEchanges extends StatefulWidget {
  List<dynamic> echanges;

  HistoryEchanges({super.key, required this.echanges});

  @override
  State<HistoryEchanges> createState() => _HistoryEchangesState();
}

class _HistoryEchangesState extends State<HistoryEchanges> {
  @override
  Widget build(BuildContext context) {
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
            const SizedBox(
              width: 10,
            ),
            Text(
              "Historique des échanges",
              style: kTitleTextStyle(
                  customFontSize:
                  ResponsiveManager.setFont(context)),
            )
          ],
        ),
        const CustomSpacer(),
        SizedBox(
          height: 420,
          child: ListView(
              children: widget.echanges.isEmpty
                  ? [const Center(child: Text("Aucun historique"))]
                  : widget.echanges.map<Widget>((e) {
                return ExchangeHistoryCard(
                  history: e,
                );
              }).toList()),
        ),
      ],
    );;
  }
}

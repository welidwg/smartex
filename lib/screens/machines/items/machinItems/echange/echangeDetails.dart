import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartex/Api/machines/MachinesRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/ResponsiveManager.dart';
import 'package:smartex/components/Titles/HeadLine.dart';
import 'package:smartex/constants.dart';

class EchangeDetails extends StatefulWidget {
  List<dynamic> echange = [];

  Function updateView;

  EchangeDetails({super.key, required this.echange, required this.updateView});

  @override
  State<EchangeDetails> createState() => _EchangeDetailsState();
}

class _EchangeDetailsState extends State<EchangeDetails> {
  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.echange[0]["date_heure"]));
    String heure = DateFormat('HH:mm')
        .format(DateTime.parse(widget.echange[0]["date_heure"]));
    return Column(
      children: [
        HeadLine(
          title:
              "Echange du machine",
          fontS: ResponsiveManager.setFont(context),
          color: kPrimaryColor,
          icon: Icons.compare_arrows,
        ),
        const CustomSpacer(),
        Row(
          children: [
            Text(
              "Chaine de destination :",
              style: TextStyle(
                  fontSize: ResponsiveManager.setFont(context),
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            ),
            Text(
              " ${widget.echange[0]["chaine_to"]["libelle"]}",
              style: TextStyle(fontSize: ResponsiveManager.setFont(context)),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "Date d'échange :",
              style: TextStyle(
                  fontSize: ResponsiveManager.setFont(context),
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            ),
            Text(
              "$date - $heure",
              style: TextStyle(fontSize: ResponsiveManager.setFont(context)),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        MyActionButton(
          label: "Annuler",
          color: kPrimaryColor,
          onPressed: () async {
            await _cancelExchange(context);
          },
        )
      ],
    );
  }

  _cancelExchange(BuildContext context) async {
    var data = {"id": widget.echange[0]["id"]};
    var res = await MachinesRequestManager.cancelExchange(data);
    if (res["type"] == "success") {
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res['message'])));
        setState(() {});
        widget.updateView();
      }
    } else {
      print(res['message']);
    }
  }
}

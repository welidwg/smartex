import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Cards/Card.dart';
import 'package:smartex/components/graphs/bar_graph.dart';
import 'package:smartex/constants.dart';

class MobileHome extends StatefulWidget {
  final double width;

  const MobileHome({super.key, required this.width});

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  @override
  Widget build(BuildContext context) {
    List<double> expenses = [22, 27, 40, 11, 70, 91, 9];
    return Column(
      children: [
        SizedBox(
          width: widget.width,
          height: 400,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(9),
            children: [
          CustomCard(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Titre du statistique",style: kContentTextStyle(customFontSize: 17).copyWith(fontWeight: FontWeight.bold),),
            ),
            MyBarGraph(
              width: widget.width,
              weeklySummery: expenses,
            ),
              ],
            ),
            width: widget.width - 40,
          ),
          const SizedBox(width: 9,),
          CustomCard(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Titre du statistique",style: kContentTextStyle(customFontSize: 17).copyWith(fontWeight: FontWeight.bold),),
                ),
                MyBarGraph(
                  width: widget.width,
                  weeklySummery: expenses,
                ),
              ],
            ),
            width: widget.width - 40,
          ),
            ],
          ),
        )
      ],
    );
  }
}

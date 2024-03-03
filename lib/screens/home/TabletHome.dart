import 'package:flutter/cupertino.dart';
import 'package:smartex/components/Cards/Card.dart';
import 'package:smartex/components/graphs/bar_graph.dart';
import 'package:smartex/constants.dart';

class TabletHome extends StatefulWidget {
  const TabletHome({super.key, required this.width});

  final double width;

  @override
  State<TabletHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<TabletHome> {
  List<double> expenses = [22, 27, 40, 11, 70, 91, 9];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.width,
          height: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCard(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "Titre du statistique",
                        style: kContentTextStyle(customFontSize: 17)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    MyBarGraph(
                      width: widget.width,
                      weeklySummery: expenses,
                    ),
                  ],
                ),
                width: (widget.width / 2) - 50,
              ),
              SizedBox(
                width: 20,
              ),
              CustomCard(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Titre du statistique",
                        style: kContentTextStyle(customFontSize: 17)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    MyBarGraph(
                      width: widget.width,
                      weeklySummery: expenses,
                    ),
                  ],
                ),
                width: (widget.width / 2) - 50,
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:smartex/components/graphs/bar_data.dart';
import 'package:smartex/constants.dart';

class MyBarGraph extends StatefulWidget {
  final double width;
  final List weeklySummery;

  const MyBarGraph(
      {super.key, required this.width, required this.weeklySummery});

  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  @override
  Widget build(BuildContext context) {
    BarData data = BarData(
        sunAmount: widget.weeklySummery[0],
        monAmount: widget.weeklySummery[1],
        tueAmount: widget.weeklySummery[2],
        wedAmount: widget.weeklySummery[3],
        thuAmount: widget.weeklySummery[4],
        friAmount: widget.weeklySummery[5],
        satAmount: widget.weeklySummery[6]);
    data.initBarData();
    return Expanded(
      child: Container(
          width: widget.width,
          padding: EdgeInsets.all(8),
          child: BarChart(BarChartData(
              maxY: 100,
              minY: 0,
              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                show: true,
                topTitles: AxisTitles(sideTitles: SideTitles(
                  getTitlesWidget: (value, meta) {
                    print(value);
                    return SideTitleWidget(
                        child: Text(
                          value.toString(),
                          style: TextStyle(
                              color: kPrimaryColor, fontSize: kMobileFont),
                        ),
                        axisSide: meta.axisSide);
                  },
                )),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              barGroups: data.barData
                  .map((e) => BarChartGroupData(x: e.x, barRods: [
                        BarChartRodData(
                            toY: e.y,
                            color: kPrimaryColor,
                            width: 14,
                            borderRadius: BorderRadius.circular(4),
                            backDrawRodData: BackgroundBarChartRodData(
                                color: CupertinoColors.white, show: true, toY: 100))
                      ]))
                  .toList()))),
    );
  }
}

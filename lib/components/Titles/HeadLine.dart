import 'package:flutter/cupertino.dart';
import 'package:smartex/constants.dart';

class HeadLine extends StatefulWidget {
  String title;
  IconData? icon;
  double fontS;
Color color;
  HeadLine({super.key, this.icon, required this.title, required this.fontS,required this.color});

  @override
  State<HeadLine> createState() => _HeadLineState();
}

class _HeadLineState extends State<HeadLine> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(widget.icon ?? widget.icon, color: kPrimaryColor),
        Text(
          widget.title,
          style: kTitleTextStyle(customFontSize: widget.fontS)
              .copyWith(color: widget.color),
        ),
      ],
    );
  }
}

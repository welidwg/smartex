import 'package:flutter/cupertino.dart';
import 'package:smartex/constants.dart';

class SecondaryCard extends StatefulWidget {
  Widget content;

  SecondaryCard({super.key, required this.content});

  @override
  State<SecondaryCard> createState() => _SecondaryCardState();
}

class _SecondaryCardState extends State<SecondaryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kSecondaryColor.withOpacity(0.5)),
    child: widget.content,);
  }
}

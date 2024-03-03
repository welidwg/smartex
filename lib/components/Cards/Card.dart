import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/constants.dart';

class CustomCard extends StatefulWidget {
  final Widget content;
  late double? width;
  late double? padding;

  CustomCard({super.key, required this.content, this.width, this.padding});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width ?? 0,
        padding:
            EdgeInsets.all(widget.padding != null ? widget.padding! : 16.0),
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.4), // Couleur de fond
          borderRadius: BorderRadius.circular(16.0), // Bord arrondi
        ),
        child: Center(child: widget.content));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartex/constants.dart';

class MyActionButton extends StatefulWidget {
  MyActionButton(
      {super.key,
        this.onPressed,
        required this.label,
        required this.color,
        this.icon});

  late VoidCallback? onPressed;
  late String label;
  late Color color;
  late IconData? icon;

  @override
  State<MyActionButton> createState() => _MyActionButtonState();
}

class _MyActionButtonState extends State<MyActionButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      elevation: 5.0,
      textStyle: TextStyle(color: Colors.white,fontSize: 10),
      child: MaterialButton(
          padding: const EdgeInsets.all(0),
          onPressed: widget.onPressed,
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style:  TextStyle(color: kSecondaryColor,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'Font1')
                ),
                const SizedBox(
                  width: 6,
                ),
                widget.icon != null
                    ? Icon(
                  widget.icon,
                  color: kSecondaryColor,
                  size: 20,
                )
                    : Container()
              ],
            ),
          )),
    );
  }
}

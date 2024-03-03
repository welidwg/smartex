import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Titles/HeadLine.dart';
import 'package:smartex/constants.dart';

class BlurredModal extends StatefulWidget {
  Widget content;
  double width;
   BlurredModal({super.key,required this.content,required this.width});

  @override
  State<BlurredModal> createState() => _BlurredModalState();
}

class _BlurredModalState extends State<BlurredModal> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.transparent,
      height: height,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 19, sigmaY: 15),
            child: Container(
              width: width ,
              color: Colors.transparent,
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child:widget.content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

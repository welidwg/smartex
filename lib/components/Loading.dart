import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/constants.dart';

class LoadingComponent extends StatefulWidget {
  Color color;

  LoadingComponent({super.key, this.color = kPrimaryColor});

  @override
  State<LoadingComponent> createState() => _LoadingComponentState();
}

class _LoadingComponentState extends State<LoadingComponent> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.4,
      child: CircularProgressIndicator(color: widget.color),
    );
  }
}

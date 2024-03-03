import 'package:flutter/cupertino.dart';
import 'package:smartex/constants.dart';

class ModalContent extends StatefulWidget {
  final Widget content;

  const ModalContent({super.key, required this.content});

  @override
  State<ModalContent> createState() => _ModalContentState();
}

class _ModalContentState extends State<ModalContent> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        //margin: width>kMobileWidth ? EdgeInsets.only(left: width*0.4) : EdgeInsets.zero,
        //height: width>kMobileWidth ? height*0.4 : height*0.36,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: CupertinoColors.white),
        padding: EdgeInsets.all(18),
        child: SingleChildScrollView(child: widget.content),
      ),
    );
  }
}

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
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: CupertinoColors.white),
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: widget.content,
        ),
      )),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/constants.dart';

class ModalManager {
  static Future showModal(
      {required Widget content, required BuildContext context}) {
    double width = MediaQuery.of(context).size.width;
    return showModalBottomSheet(
        constraints: BoxConstraints(
            maxWidth: width > kMobileWidth ? width * 0.5 : width),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ct){
          return ModalContent(content: content);
        });
  }
}

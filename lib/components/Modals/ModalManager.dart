import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smartex/components/Modals/ModalContent.dart';

class ModalManager {

  Future showModal({required Widget content, required BuildContext context}) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: ((context) {
          return ModalContent(content: content);
        }),
        isScrollControlled: true);
  }
}

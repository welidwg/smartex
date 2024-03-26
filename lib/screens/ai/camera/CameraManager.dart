import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Modals/ModalManager.dart';
import 'package:smartex/screens/ai/camera/CameraScreen.dart';
import 'package:smartex/screens/qr/QrCodeScreen.dart';

class CameraManager {
  static Future<void> openCameraScreen(
      BuildContext context, Function setter) async {
    ModalManager.showModal(
        content: QrCodeScreen(
          setter: setter,
        ),
        context: context);
  }
}

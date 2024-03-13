import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/screens/ai/camera/CameraScreen.dart';

class CameraManager {
  static Future<void> openCameraScreen(
      BuildContext context, Function setter) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CameraScreen(
                setter: setter,
              )),
    );
  }
}

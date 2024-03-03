import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  static const String id = "camera_screen";

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  late List cameras;
  late int selectedCameraIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    availableCameras().then((value) {
      cameras = value;
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIndex = 0;
        });
        _initCameraController(cameras[selectedCameraIndex]);
      }
    });
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    controller = CameraController(cameraDescription, ResolutionPreset.high);
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print("error camera $e");
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width= MediaQuery.of(context).size.width;
    if (controller == null || !controller.value.isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Stack(
            children: [
              CameraPreview(controller),
              Center(
                child: Container(
                  width: width, // Largeur du rectangle
                  height: 100.0, // Hauteur du rectangle
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          )),
          ElevatedButton(
              onPressed: () {
                _onCapturePressed(context);
              },
              child: Icon(Icons.camera)),
        ],
      ),
    );
  }

  void _onCapturePressed(BuildContext context) async {
    try {
      XFile file = await controller.takePicture();
      String base64Image = base64Encode(File(file.path).readAsBytesSync());
      const url = 'http://192.168.1.16:5000/process_image';
      Uint8List bytes = base64.decode(base64Image);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          bytes,
          filename: 'temp_image.jpg',
        ),
      );
      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          print(response);
          var body=await response.stream.bytesToString();
          print(body);
          Navigator.pop(context);
        } else {
          print('Erreur lors de l\'envoi de l\'image à l\'API');
        }
      } catch (e) {
        print('Erreur lors de l\'envoi de la requête : $e');
      }
    } catch (e) {
      print(e);
    }
  }
}

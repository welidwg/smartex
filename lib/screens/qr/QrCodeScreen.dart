import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/constants.dart';

class QrCodeScreen extends StatefulWidget {
  QrCodeScreen({super.key, this.setter});

  late Function? setter;
  static const String id = "qr_screen";

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final GlobalKey qrKey = GlobalKey();
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    var scanArea = 250.0;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      color: CupertinoColors.black,
      child: Column(
        children: <Widget>[
          result != null
              ? Text(
                  result!.code.toString(),
                  style: TextStyle(color: Colors.white),
                )
              : Container(),
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (QRViewController ct) {
                ct.scannedDataStream.listen((scanData) {
                  setState(() {
                    result = scanData;
                  });
                  widget.setter!(result!.code);
                  ct.dispose();
                  Navigator.pop(context);
                });
              },
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.white,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: scanArea),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void resumecamara() {
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }
}

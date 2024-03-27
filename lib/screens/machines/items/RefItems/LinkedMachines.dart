import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Title.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/ai/camera/CameraManager.dart';
import 'package:smartex/screens/machines/items/MachineCard.dart';

class LinkedMachines extends StatefulWidget {
  late Map<String, dynamic> ref;

  LinkedMachines({super.key, required this.ref});

  @override
  State<LinkedMachines> createState() => _LinkedMachinesState();
}

class _LinkedMachinesState extends State<LinkedMachines> {
  late TextEditingController codeCtrl;
  String search = '';
  bool isLoading = true;

  void _setCode(String value) {
    String noSpace = value.replaceAll(RegExp(r'\s+'), '');

    setState(() {
      codeCtrl = TextEditingController(text: noSpace);
      search = noSpace;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeCtrl = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        TitleComponent(
            title: "Machines liées avec ${widget.ref["ref"]}",
            icon: CupertinoIcons.gear_solid),
        const CustomSpacer(),
        Input(
            controller: codeCtrl,
            vPadding: 0,
            hPadding: 7,
            suffixIc: GestureDetector(
              child: const Icon(
                Icons.qr_code_scanner_sharp,
                size: 20,
              ),
              onTap: () {
                CameraManager.openCameraScreen(context, _setCode);
              },
            ),
            label: "Code",
            is_Password: false,
            onChange: (value) {
              setState(() {
                search = value;
              });
            }),
        const CustomSpacer(),
        Container(
            height: 300,
            width: width,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: CupertinoColors.white,
              boxShadow: const [
                BoxShadow(
                  color: kSecondaryColor,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(1, 1),
                ),
              ],
            ),
            child: widget.ref.isEmpty || widget.ref["machines"].length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text("Aucune machine liée à cette référence"),
                    ],
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      if(widget.ref["machines"][index]["code"].toString().toLowerCase().contains(search.toLowerCase())){
                        return MachineCard(
                          type: "ma",
                          item: widget.ref["machines"][index],
                          updateView: () {},
                        );
                      }

                    },
                    itemCount: widget.ref["machines"].length,
                  ))
      ],
    );
    ;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/Api/machines/MachinesRequestManager.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Placeholders/ListPlaceHolder.dart';
import 'package:smartex/components/Title.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/ai/camera/CameraScreen.dart';
import 'package:smartex/screens/machines/items/MachineCard.dart';
import 'package:smartex/screens/qr/QrCodeScreen.dart';

class AllMachineScreen extends StatefulWidget {
  AllMachineScreen({super.key, required this.machines});

  late List<dynamic> machines = [];

  @override
  State<AllMachineScreen> createState() => _AllMachineScreenState();
}

class _AllMachineScreenState extends State<AllMachineScreen> {
  late TextEditingController codeCtrl;
  late List<dynamic> machines = [];
  MachinesRequestManager manager = MachinesRequestManager();
  String search = '';
  bool isLoading = true;

  initMachines() async {
    //machines = await manager.getMachinesList(search: search);
    machines = widget.machines;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeCtrl = TextEditingController(text: "");
    initMachines();
  }

  Future<void> _openCameraScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (ct) => QrCodeScreen(
                setter: _setCode,
              )),
    );
  }

  void _setCode(String value) {
    String noSpace = value.replaceAll(RegExp(r'\s+'), '');

    setState(() {
      codeCtrl = TextEditingController(text: noSpace);
      search = noSpace;
    });
    //initMachines();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const TitleComponent(
            title: "Tous les machines", icon: CupertinoIcons.gear_solid),
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
                _openCameraScreen(context);
              },
            ),
            label: "Code",
            is_Password: false,
            onChange: (value) {
              setState(() {
                search = value;
                isLoading = true;
              });
              initMachines();
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
          child: isLoading
              ? ListPlaceholder()
              : machines.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Aucune machine trouvée"),
                      ],
                    )
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      //padding: EdgeInsets.only(bottom: 16),
                      children: machines.map((e) {
                        if (e["code"]
                            .toString()
                            .toLowerCase()
                            .contains(search.toLowerCase())) {
                          return MachineCard(
                            type: "ma",
                            item: e,
                            updateView: initMachines,
                          );
                        } else {
                          return Container();
                        }
                      }).toList()),
        )
      ],
    );
  }
}

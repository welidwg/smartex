import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/Api/machines/MachinesRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Loading.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/components/Modals/ModalManager.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/ai/camera/CameraManager.dart';
import 'package:smartex/screens/ai/camera/CameraScreen.dart';
import 'package:smartex/screens/machines/items/MachineCard.dart';
import 'package:smartex/screens/machines/items/forms/AddMachineForm.dart';
import 'package:smartex/screens/machines/items/machinItems/AllMachines.dart';
import 'package:smartex/screens/qr/QrCodeScreen.dart';

class MachinesList extends StatefulWidget {
  MachinesList({super.key, this.updateView});

  Function? updateView;

  @override
  State<MachinesList> createState() => _MachinesListState();
}

class _MachinesListState extends State<MachinesList> {
  late TextEditingController codeCtrl;
  late List<dynamic> machines = [];

  MachinesRequestManager manager = MachinesRequestManager();
  String search = '';
  bool isLoading = true;

  initMachines() async {
    setState(() {
      isLoading = true;
    });
    if (mounted) {
      machines = await manager.getMachinesList(search: search);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeCtrl = TextEditingController(text: "");
    if (mounted) {
      initMachines();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const CustomSpacer(),
        Container(
          margin: const EdgeInsets.only(left: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.gear_alt_fill,
                        color: kPrimaryColor,
                      ),
                      Text(
                        "Machines",
                        style: kTitleTextStyle(
                            customFontSize: width > kMobileWidth
                                ? kTabletFont
                                : kMobileFont + 1),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: FloatingActionButton(
                      elevation: 1,
                      mini: true,
                      onPressed: () {
                        ModalManager.showModal(
                            content: AddMachineForm(
                              updateView: initMachines,
                            ),
                            context: context);
                      },
                      backgroundColor: kPrimaryColor,
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: width / 3,
                child: Input(
                    controller: codeCtrl,
                    isEnabled: !isLoading,
                    vPadding: 0,
                    hPadding: 7,
                    suffixIc: GestureDetector(
                      child: const Icon(
                        Icons.qr_code_scanner_sharp,
                        size: 20,
                      ),
                      onTap: () {
                        CameraManager.openCameraScreen(context, _setCode);
                        //_openCameraScreen(context);
                      },
                    ),
                    label: "Code",
                    is_Password: false,
                    onChange: (value) {
                      setState(() {
                        search = value;
                        //isLoading = true;
                      });
                      //initMachines();
                    }),
              ),
            ],
          ),
        ),
        const CustomSpacer(),
        Container(
          height: 100,
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
              ? Center(
                  child: LoadingComponent(),
                )
              : machines.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Aucune machine trouvée"),
                      ],
                    )
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
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
        ),
        const SizedBox(
          height: 8,
        ),
        !isLoading
            ? GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Text(
                        "Afficher tous",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: width > kMobileWidth
                                ? kTabletFont
                                : kMobileFont),
                      ),
                      onTap: () {
                        ModalManager.showModal(
                            content: AllMachineScreen(machines: machines),
                            context: context);
                      },
                    ),
                    const Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              )
            : Container()
      ],
    );
  }

  void _setCode(String value) {
    String noSpace = value.replaceAll(RegExp(r'\s+'), '');
    setState(() {
      codeCtrl = TextEditingController(text: noSpace);
      search = noSpace;
    });
    initMachines();
  }

  Future<void> _openCameraScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => QrCodeScreen(
                setter: _setCode,
              )),
    );
  }
}

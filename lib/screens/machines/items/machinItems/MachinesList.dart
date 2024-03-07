import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/Api/machines/MachinesRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Loading.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/ai/CameraScreen.dart';
import 'package:smartex/screens/machines/items/MachineCard.dart';
import 'package:smartex/screens/machines/items/forms/AddMachineForm.dart';
import 'package:smartex/screens/machines/items/machinItems/AllMachines.dart';

class MachinesList extends StatefulWidget {
  const MachinesList({super.key});

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
    machines = await manager.getMachinesList(search: search);
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
                        "Machines en stock",
                        style: kTitleTextStyle(
                            customFontSize: width > kMobileWidth
                                ? kTabletFont - 2
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
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: ((context) {
                              return ModalContent(
                                  content: AddMachineForm(
                                updateView: initMachines,
                              ));
                            }),
                            isScrollControlled: true);
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
                        return MachineCard(
                          type: "ma",
                          item: e,
                          updateView: initMachines,
                        );
                      }).toList()),
        ),
        const SizedBox(
          height: 8,
        ),
        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: const Text(
                  "Afficher tous",
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return const ModalContent(content: AllMachineScreen());
                      });
                },
              ),
              const Icon(Icons.keyboard_arrow_down)
            ],
          ),
        )
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
          builder: (context) => CameraScreen(
                setter: _setCode,
              )),
    );
  }
}

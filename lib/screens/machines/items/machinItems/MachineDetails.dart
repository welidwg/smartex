import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/Api/chaines/ChainesRequestManager.dart';
import 'package:smartex/Api/etat/EtatRequestManager.dart';
import 'package:smartex/Api/machines/MachinesRequestManager.dart';
import 'package:smartex/Api/references/ReferencesRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomDropdown.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Loading.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/components/Placeholders/FormPlaceholder.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/machines/items/machinItems/History.dart';

class MachineDetails extends StatefulWidget {
  final Function updateView;
  final Map<String, dynamic> machine;

  const MachineDetails(
      {super.key, required this.updateView, required this.machine});

  @override
  State<MachineDetails> createState() => _MachineDetailsState();
}

class _MachineDetailsState extends State<MachineDetails> {
  bool isLoading = true;
  bool isLoadingForm = false;
  late TextEditingController codeCtrl;
  late List<dynamic> chaines = [];
  late Map<int, dynamic> parcs = {};
  late List<dynamic> refs = [];
  late List<dynamic> etats = [];
  late int defaultChaine;
  late int defaultEtat;
  late int defaultRef;
  late int defaultParc = 0;
  ChainesRequestManager chaineManager = ChainesRequestManager();
  EtatRequestManager etatManager = EtatRequestManager();
  ReferencesRequestManager refManager = ReferencesRequestManager();
  MachinesRequestManager machineManager = MachinesRequestManager();

  initList() async {
    chaines = await chaineManager.getChainesList(search: "");
    etats = await etatManager.getEtatList(search: "");
    refs = await refManager.getRefsList(search: "");
    setState(() {
      defaultChaine = widget.machine["id_chaine"];
      defaultEtat = widget.machine["id_etat"];
      defaultRef = widget.machine["id_reference"];
      defaultParc = 0;
      isLoading = false;
      isLoadingForm = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parcs[0] = "Parc stock";
    parcs[1] = "Parc occupé";
    codeCtrl = TextEditingController(text: widget.machine["code"]);
    initList();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Column(
      children: isLoading
          ? [const FormPlaceHolder()]
          : [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const Icon(
                  //   CupertinoIcons.gear_solid,
                  //   color: kPrimaryColor,
                  //   size: 19,
                  // ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    "${widget.machine["reference"]["ref"]}#${widget.machine["code"]}",
                    style: kTitleTextStyle(
                        customFontSize: width > kMobileWidth
                            ? kTabletFont - 2
                            : kMobileFont+2),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Modifier la référence",
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  refs.isEmpty
                      ? kPlaceholder
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 19),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: kPrimaryColor, width: 2),
                              borderRadius: BorderRadius.circular(7)),
                          child: DropdownButton(
                              elevation: 0,
                              dropdownColor: kSecondaryColor,
                              style: const TextStyle(
                                  color: kPrimaryColor, fontFamily: "Font1"),
                              borderRadius: BorderRadius.circular(10),
                              isExpanded: true,
                              value: defaultRef,
                              onTap: () {
                                setState(() {});
                              },
                              icon: const Icon(Icons.arrow_drop_down),
                              items: refs.map((value) {
                                return DropdownMenuItem(
                                  value: value["id"],
                                  child: Text(
                                    value["ref"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            width > kMobileWidth ? 18 : 13,
                                        fontFamily: "Font1"),
                                  ),
                                );
                              }).toList(),
                              onChanged: (dynamic newVal) {
                                setState(() {
                                  defaultRef = newVal;
                                });
                                // widget.setter!(int.parse(newVal));
                              }),
                        ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Modifier le code",
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Input(
                    label: "Code",
                    is_Password: false,
                    onChange: (value) {},
                    vPadding: 17,
                    controller: codeCtrl,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Modifier l'état",
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  etats.isEmpty
                      ? kPlaceholder
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 19),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: kPrimaryColor, width: 2),
                              borderRadius: BorderRadius.circular(7)),
                          child: DropdownButton(
                              elevation: 0,
                              dropdownColor: kSecondaryColor,
                              style: const TextStyle(
                                  color: kPrimaryColor, fontFamily: "Font1"),
                              borderRadius: BorderRadius.circular(10),
                              isExpanded: true,
                              value: defaultEtat,
                              onTap: () {
                                setState(() {});
                              },
                              icon: const Icon(Icons.arrow_drop_down),
                              items: etats.map((value) {
                                return DropdownMenuItem(
                                  value: value["id"],
                                  child: Text(
                                    value["libelle"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            width > kMobileWidth ? 18 : 13,
                                        fontFamily: "Font1"),
                                  ),
                                );
                              }).toList(),
                              onChanged: (dynamic newVal) {
                                setState(() {
                                  defaultEtat = newVal;
                                });
                                // widget.setter!(int.parse(newVal));
                              }),
                        ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Modifier la chaîne",
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  chaines.isEmpty
                      ? kPlaceholder
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 19),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: kPrimaryColor, width: 2),
                              borderRadius: BorderRadius.circular(7)),
                          child: DropdownButton(
                              elevation: 0,
                              dropdownColor: kSecondaryColor,
                              style: const TextStyle(
                                  color: kPrimaryColor, fontFamily: "Font1"),
                              borderRadius: BorderRadius.circular(10),
                              isExpanded: true,
                              value: defaultChaine,
                              onTap: () {
                                setState(() {});
                              },
                              icon: const Icon(Icons.arrow_drop_down),
                              items: chaines.map((value) {
                                return DropdownMenuItem(
                                  value: value["id"],
                                  child: Text(
                                    value["libelle"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            width > kMobileWidth ? 18 : 13,
                                        fontFamily: "Font1"),
                                  ),
                                );
                              }).toList(),
                              onChanged: (dynamic newVal) {
                                setState(() {
                                  defaultChaine = newVal;
                                });
                                // widget.setter!(int.parse(newVal));
                              }),
                        ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Modifier le parc",
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 19),
                    decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(7)),
                    child: DropdownButton(
                        elevation: 0,
                        dropdownColor: kSecondaryColor,
                        style: const TextStyle(
                            color: kPrimaryColor, fontFamily: "Font1"),
                        borderRadius: BorderRadius.circular(10),
                        isExpanded: true,
                        value: defaultParc,
                        onTap: () {
                          setState(() {});
                        },
                        icon: const Icon(Icons.arrow_drop_down),
                        items: parcs.keys.map((int value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              parcs[value],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width > kMobileWidth ? 18 : 13,
                                  fontFamily: "Font1"),
                            ),
                          );
                        }).toList(),
                        onChanged: (dynamic newVal) {
                          setState(() {
                            defaultParc = newVal;
                          });
                          // widget.setter!(int.parse(newVal));
                        }),
                  ),
                ],
              ),
              const CustomSpacer(),
              isLoadingForm
                  ? LoadingComponent()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: MyActionButton(
                          label: "",
                          color: kPrimaryColor,
                          icon: Icons.save_as,
                          isLoading: isLoadingForm,
                          onPressed: () async {
                            setState(() {
                              isLoadingForm = true;
                            });
                            await _saveMachineData(context);
                          },
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: MyActionButton(
                          label: "",
                          color: kPrimaryColor,
                          icon: Icons.manage_history,
                          onPressed: () {
                            //Navigator.pop(context);
                            showModalBottomSheet(
                                isScrollControlled: true,
                                enableDrag: true,
                                context: context,
                                builder: (context) {
                                  return const ModalContent(
                                      content: HistoryMachine());
                                });
                          },
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        MyActionButton(
                          label: "",
                          color: Colors.pink,
                          icon: Icons.delete_sweep,
                          onPressed: () async {
                            setState(() {
                              isLoadingForm = true;
                            });
                            await _deleteMachineData(context);
                          },
                        )
                      ],
                    )
            ],
    );
    ;
  }

  _saveMachineData(BuildContext context) async {
    Map<String, dynamic> data = {
      "id": widget.machine["id"],
      "code": codeCtrl.text,
      "id_etat": defaultEtat,
      "id_chaine": defaultChaine,
      "id_reference": defaultRef,
      "parc": defaultParc
    };
    var res = await machineManager.editMachines(data);
    if (res["type"] == "success") {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res['message'])));
      setState(() {});
      widget.updateView();
    } else {
      print(res['message']);
    }
  }

  _deleteMachineData(BuildContext context) async {
    Map<String, dynamic> data = {
      "id": widget.machine["id"],
    };
    var res = await machineManager.deleteMachines(data);
    if (res["type"] == "success") {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res['message'])));
      setState(() {});
      widget.updateView();
    } else {
      print(res['message']);
    }
  }
}

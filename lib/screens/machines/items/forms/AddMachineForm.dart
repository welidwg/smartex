import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartex/Api/chaines/ChainesRequestManager.dart';
import 'package:smartex/Api/etat/EtatRequestManager.dart';
import 'package:smartex/Api/machines/MachinesRequestManager.dart';
import 'package:smartex/Api/references/ReferencesRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomDropdown.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/components/Placeholders/FormPlaceholder.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/ai/CameraScreen.dart';

class AddMachineForm extends StatefulWidget {
  Function? updateView;

  AddMachineForm({super.key, required this.updateView});

  @override
  State<AddMachineForm> createState() => _AddMachineFormState();
}

class _AddMachineFormState extends State<AddMachineForm> {
  late String code = "";
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
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

  void _setCode(String value) {
    setState(() {
      codeCtrl = TextEditingController(text: value);
    });
  }

  initList() async {
    chaines = await chaineManager.getChainesList(search: "");
    etats = await etatManager.getEtatList(search: "");
    refs = await refManager.getRefsList(search: "");
    setState(() {
      defaultChaine = chaines.first["id"];
      defaultEtat = etats.first["id"];
      defaultRef = refs.first["id"];
      defaultParc = 0;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeCtrl = TextEditingController(text: code);
    parcs[0] = "Parc stock";
    parcs[1] = "Parc occupé";
    initList();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Column(
        children: isLoading
            ? [
                const FormPlaceHolder(),
              ]
            : [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.gear_solid,
                      color: kPrimaryColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Ajouter une machine",
                      style: kTitleTextStyle(
                          customFontSize: width > kMobileWidth
                              ? kTabletFont - 2
                              : kMobileFont),
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
                      "Choisissez la référence",
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
                      "Saisissez le code",
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Input(
                        controller: codeCtrl,
                        value: code,
                        label: "Code",
                        message: "Veuillez saisir le code du machine",
                        is_Password: false,
                        onChange: (value) {},
                        vPadding: 17,
                        suffixIc: GestureDetector(
                          onTap: () async {
                            await _openCameraScreen(context);
                          },
                          child: const Icon(Icons.qr_code_scanner_rounded),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Choisissez l'état",
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
                      "Choisissez la chaîne",
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
                      "Choisissez le parc",
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    parcs == null
                        ? const CircularProgressIndicator()
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
                                          fontSize:
                                              width > kMobileWidth ? 18 : 13,
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
                MyActionButton(
                  label: "Ajouter",
                  color: kPrimaryColor,
                  isLoading: isLoading,
                  onPressed: () async {

                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      await _addMachine(context);
                    }
                  },
                )
              ],
      ),
    );
    ;
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

  _addMachine(BuildContext context) async {
    Map<String, dynamic> data = {
      "code": codeCtrl.text,
      "id_etat": defaultEtat,
      "id_chaine": defaultChaine,
      "id_reference": defaultRef,
      "parc": defaultParc
    };
    var res = await machineManager.addMachines(data);
    if (res["type"] == "success") {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res['message'])));
      widget.updateView!();
    } else {
      print(res['message']);
    }
    setState(() {
      isLoading=false;
    });
  }
}

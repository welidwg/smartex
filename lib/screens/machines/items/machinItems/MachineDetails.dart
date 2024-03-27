import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/Api/chaines/ChainesRequestManager.dart';
import 'package:smartex/Api/etat/EtatRequestManager.dart';
import 'package:smartex/Api/history/HistoryRequestManager.dart';
import 'package:smartex/Api/machines/MachinesRequestManager.dart';
import 'package:smartex/Api/references/ReferencesRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomDropdown.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Loading.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/components/Modals/ModalManager.dart';
import 'package:smartex/components/Placeholders/FormPlaceholder.dart';
import 'package:smartex/components/ResponsiveManager.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/machines/items/machinItems/history/History.dart';
import 'package:smartex/screens/machines/items/machinItems/activities/ActivitiesScreen.dart';
import 'package:smartex/screens/machines/items/machinItems/echange/HistoryEchanges.dart';
import 'package:smartex/screens/machines/items/machinItems/echange/echangeDetails.dart';
import 'package:smartex/screens/machines/items/machinItems/echange/echangeScreen.dart';
import 'package:smartex/storage/LocalStorage.dart';

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
  late int defaultParc;

  ChainesRequestManager chaineManager = ChainesRequestManager();
  EtatRequestManager etatManager = EtatRequestManager();
  ReferencesRequestManager refManager = ReferencesRequestManager();
  MachinesRequestManager machineManager = MachinesRequestManager();
  bool isActiveExchange = false;
  List<dynamic> echanges = [];
  List<dynamic> echangeActif = [];
  late Map<String, dynamic> estimations = {};
  DateTime aujourdhui = DateTime.now();
  late DateTime? targetDate;

  initList() async {
    chaines = await chaineManager.getChainesList(search: "");
    etats = await etatManager.getEtatList(search: "");
    refs = await refManager.getRefsList(search: "");
    estimations = await HistoryRequestManager.getEstimation(
        {"id_machine": widget.machine['id']});

    setState(() {
      defaultChaine = widget.machine["id_chaine"];
      defaultEtat = widget.machine["id_etat"];
      defaultRef = widget.machine["id_reference"];
      defaultParc = widget.machine["parc"];
      isLoading = false;
      isLoadingForm = false;
      isActiveExchange =
          widget.machine["echanges"].any((echange) => echange['isActive'] == 1);
      echanges = widget.machine["echanges"];
      echangeActif = echanges.where((ex) => ex["isActive"] == 1).toList();
      if (estimations["type"] == "success") {
        targetDate = DateTime.parse(estimations["estimated"]);
      } else {
        targetDate = null;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parcs[0] = "Parc stock";
    parcs[1] = "Chaîne";
    codeCtrl = TextEditingController(text: widget.machine["code"]);
    initList();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Column(
      children: isLoading
          ? [
              const FormPlaceHolder(),
            ]
          : [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    "Machine ${widget.machine["code"]}",
                    style: kTitleTextStyle(
                        customFontSize: width > kMobileWidth
                            ? kTabletFont - 2
                            : kMobileFont + 2),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              targetDate != null
                  ? targetDate!.difference(aujourdhui).inDays <= 7 &&
                          targetDate!.difference(aujourdhui).inDays >= 0
                      ? GestureDetector(
                          onTap: () {
                            ModalManager.showModal(
                                context: context,
                                content: HistoryMachine(
                                  updateView: widget.updateView,
                                  machine: widget.machine,
                                ));
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.redAccent.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.warning_rounded,
                                      color: kPrimaryColor,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "Cette machine peut tomber en panne dans ${targetDate?.difference(aujourdhui).inDays != 0 ? "${targetDate?.difference(aujourdhui).inDays} ${targetDate?.difference(aujourdhui).inDays == 1 ? "jour" : "jours"}" : "aujourd'hui"}",
                                      style:
                                          const TextStyle(color: kPrimaryColor),
                                    ))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        )
                      : const SizedBox()
                  : const SizedBox(
                      height: 8,
                    ),
              if (isActiveExchange)
                GestureDetector(
                  onTap: () {
                    ModalManager.showModal(
                        context: context,
                        content: EchangeDetails(
                            echange: echangeActif,
                            updateView: widget.updateView));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 13, top: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.info_outlined,
                          color: kPrimaryColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            "Machine est en échange avec la chaîne ${echangeActif[0]["chaine_to"]["libelle"]}",
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 15,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                )
              else
                const SizedBox(
                  height: 10,
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Référence",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        refs.isEmpty
                            ? kPlaceholder
                            : Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 19),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: kPrimaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(7)),
                                child: DropdownButton(
                                    elevation: 0,
                                    underline: Container(),
                                    dropdownColor: kSecondaryColor,
                                    style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontFamily: "Font1"),
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
                                              fontSize: width > kMobileWidth
                                                  ? 18
                                                  : 13,
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
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Parc",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 19),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: kPrimaryColor, width: 2),
                              borderRadius: BorderRadius.circular(7)),
                          child: DropdownButton(
                              underline: Container(),
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
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Etat de machine",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        etats.isEmpty
                            ? kPlaceholder
                            : Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 19),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: kPrimaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(7)),
                                child: DropdownButton(
                                    underline: Container(),
                                    elevation: 0,
                                    dropdownColor: kSecondaryColor,
                                    style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontFamily: "Font1"),
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
                                              fontSize: width > kMobileWidth
                                                  ? 18
                                                  : 13,
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
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Chaîne",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        chaines.isEmpty
                            ? kPlaceholder
                            : Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 19),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: kPrimaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(7)),
                                child: DropdownButton(
                                    elevation: 0,
                                    underline: Container(),
                                    dropdownColor: kSecondaryColor,
                                    style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontFamily: "Font1"),
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
                                              fontSize: width > kMobileWidth
                                                  ? 18
                                                  : 13,
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
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              const CustomSpacer(),
              if (isLoadingForm)
                LoadingComponent()
              else
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: MyActionButton(
                          label: "",
                          color: kPrimaryColor,
                          icon: Icons.compare_arrows,
                          isLoading: isLoadingForm,
                          onPressed: () {
                            if (isActiveExchange) {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return CupertinoAlertDialog(
                                      title: const Text("Echange impossible"),
                                      content: const Text(
                                          "Cette machine est déjà en échange avec une autre chaine.Veuillez annuler cet échange pour continuer."),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                          child: const Text(
                                            "J'ai compris",
                                            style:
                                                TextStyle(color: kPrimaryColor),
                                          ),
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  }));
                            } else {
                              ModalManager.showModal(
                                  content: EchangeScreen(
                                      machine: widget.machine,
                                      updateView: () async {
                                        await widget.updateView();
                                        await initList();
                                      }),
                                  context: context);
                            }
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
                            ModalManager.showModal(
                                context: context,
                                content: Column(
                                  children: [
                                    MyActionButton(
                                      icon: CupertinoIcons.gear_solid,
                                      label: "Historique des pannes",
                                      color: kPrimaryColor,
                                      onPressed: () {
                                        if (mounted) {
                                          Navigator.pop(context);
                                        }
                                        ModalManager.showModal(
                                            context: context,
                                            content: HistoryMachine(
                                              updateView: widget.updateView,
                                              machine: widget.machine,
                                            ));
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    MyActionButton(
                                      icon: Icons.compare_arrows_sharp,
                                      label: "Historique des échanges",
                                      color: kPrimaryColor,
                                      onPressed: () {
                                        if (mounted) {
                                          Navigator.pop(context);
                                        }
                                        ModalManager.showModal(
                                            context: context,
                                            content: HistoryEchanges(
                                              echanges:
                                                  widget.machine["echanges"],
                                            ));
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    MyActionButton(
                                      icon: CupertinoIcons
                                          .person_crop_circle_fill_badge_checkmark,
                                      label: "Historique des activités",
                                      color: kPrimaryColor,
                                      onPressed: () {
                                        if (mounted) {
                                          Navigator.pop(context);
                                        }
                                        ModalManager.showModal(
                                            context: context,
                                            content: MachineActivitiesScreen(
                                                activities: widget.machine[
                                                    "historique_activite"]));
                                      },
                                    ),
                                  ],
                                ));
                          },
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
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
                          ),
                        ),
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
                        ),
                      ],
                    ),
                  ],
                ),
            ],
    );
  }

  _saveMachineData(BuildContext context) async {
    var user = await LocalStorage.getUser();
    Map<String, dynamic> data = {
      "id": widget.machine["id"],
      "code": codeCtrl.text,
      "id_etat": defaultEtat,
      "id_chaine": defaultChaine,
      "id_reference": defaultRef,
      "parc": defaultParc,
      "edited_by": user["id"]
    };
    var res = await machineManager.editMachines(data);
    if (res["type"] == "success") {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res['message'])));
        setState(() {});
        widget.updateView();
      }
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

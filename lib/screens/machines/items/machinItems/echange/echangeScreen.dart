import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartex/Api/chaines/ChainesRequestManager.dart';
import 'package:smartex/Api/machines/MachinesRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/ResponsiveManager.dart';
import 'package:smartex/components/Titles/HeadLine.dart';
import 'package:smartex/constants.dart';

class EchangeScreen extends StatefulWidget {
  final Map<String, dynamic> machine;
  Function updateView;

  EchangeScreen({super.key, required this.machine, required this.updateView});

  @override
  State<EchangeScreen> createState() => _EchangeScreenState();
}

class _EchangeScreenState extends State<EchangeScreen> {
  late List<dynamic> chaines = [];
  late int defaultChaine;
  ChainesRequestManager chaineManager = ChainesRequestManager();
  TextEditingController machineCtrl = TextEditingController(text: "");
  TextEditingController chaineCtrl = TextEditingController(text: "");
  TextEditingController dateTimeCtrl = TextEditingController(text: "");
  bool switcher = false;
  final formKey = GlobalKey<FormState>();

  initList() async {
    chaines = await chaineManager.getChainesList(search: "");
    setState(() {
      defaultChaine = chaines[0]['id'];
      machineCtrl.text = widget.machine["code"];
      chaineCtrl.text = widget.machine["chaine"]["libelle"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initList();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Form(
        key: formKey,
        child: Column(
          children: [
            HeadLine(
              title: "Echange du machine #${widget.machine["code"]}",
              fontS: ResponsiveManager.setFont(context),
              color: kPrimaryColor,
              icon: Icons.compare_arrows,
            ),
            CustomSpacer(),
            Input(
              label: "Code machine",
              is_Password: false,
              onChange: (value) {},
              isEnabled: false,
              controller: machineCtrl,
            ),
            SizedBox(
              height: 10,
            ),
            Input(
              label: "Chaine",
              is_Password: false,
              controller: chaineCtrl,
              onChange: (value) {},
              isEnabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Chaîne de destination :",
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
                            border: Border.all(color: kPrimaryColor, width: 2),
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
                            items: chaines.where((element) {
                              return element["id"] !=
                                  widget.machine["id_chaine"];
                            }).map((value) {
                              return DropdownMenuItem(
                                value: value["id"],
                                child: Text(
                                  value["libelle"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width > kMobileWidth ? 18 : 13,
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
                SizedBox(
                  height: 10,
                ),
                Input(
                  vPadding: 15,
                  controller: dateTimeCtrl,
                  suffixIc: GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        if (mounted) {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (pickedTime != null) {
                            DateTime dateTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );

                            String formattedDateTime =
                                DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
                            dateTimeCtrl.text = formattedDateTime;
                          }
                        }
                      }
                    },
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: kPrimaryColor,
                    ),
                  ),
                  label: "Date et heure",
                  is_Password: false,
                  onChange: (value) {},
                  onTap: () async {},
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Switch(
                        activeColor: kPrimaryColor,
                        value: switcher,
                        onChanged: (value) {
                          setState(() {
                            switcher = value;
                          });
                          if (switcher) {
                            String formattedDateTime =
                                DateFormat('yyyy-MM-dd HH:mm')
                                    .format(DateTime.now());
                            dateTimeCtrl.text = formattedDateTime;
                          } else {
                            dateTimeCtrl.text = "";
                          }
                        }),
                    Text('Maintenant')
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                MyActionButton(
                  label: "Echanger",
                  color: kPrimaryColor,
                  onPressed: () async {
                    await _addEchange(context);
                  },
                )
              ],
            ),
          ],
        ));
  }

  _addEchange(BuildContext context) async {
    final data = {
      'id_machine': widget.machine["id"],
      'id_chaine_from': widget.machine["id_chaine"],
      'id_chaine_to': defaultChaine,
      'date_heure': dateTimeCtrl.text,
      'isActive': switcher
    };
    var res = await MachinesRequestManager.echangeMachine(data);
    if (res["type"] == "success") {
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res['message'])));
        setState(() {});
        widget.updateView();
      }
    } else {
      print(res['message']);
    }
  }
}

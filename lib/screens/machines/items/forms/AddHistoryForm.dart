import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smartex/Api/history/HistoryRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/storage/LocalStorage.dart';

class AddHistoryForm extends StatefulWidget {
  late int? idMachine;
  late Function updateView;

  AddHistoryForm({super.key, this.idMachine, required this.updateView});

  @override
  State<AddHistoryForm> createState() => _AddHistoryFormState();
}

class _AddHistoryFormState extends State<AddHistoryForm> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isEnabled = true;
  bool switcher = false;
  TextEditingController controller = TextEditingController();
  TextEditingController historyCtrl = TextEditingController();
  TextEditingController dateTimeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.history,
                color: kPrimaryColor,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Ajouter historique machine",
                style: kTitleTextStyle(
                    customFontSize:
                        width > kMobileWidth ? kTabletFont - 2 : kMobileFont),
              )
            ],
          ),
          const CustomSpacer(),
          Input(
            label: "Historique",
            is_Password: false,
            isTextArea: true,
            onChange: (value) {},
            message: "Veuillez saisir le historique",
            controller: historyCtrl,
          ),
          const SizedBox(
            height: 13,
          ),
          Input(
            isEnabled: isEnabled,
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
                          DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
                      dateTimeCtrl.text = formattedDateTime;
                      setState(() {
                        isEnabled = false;
                      });
                    } else {
                      dateTimeCtrl.text = "";
                      setState(() {
                        isEnabled = true;
                      });
                    }
                  }),
              Text('Maintenant')
            ],
          ),
          const CustomSpacer(),
          MyActionButton(
            label: "Ajouter",
            color: kPrimaryColor,
            isLoading: isLoading,
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                });
                await addHistory(context);
                widget.updateView();
                setState(() {

                });
              }
            },
          )
        ],
      ),
    );
  }

  addHistory(BuildContext context) async {
    var user=await LocalStorage.getUser();
    Map<String, dynamic> data = {
      'id_machine': widget.idMachine,
      'date_heure': dateTimeCtrl.text,
      'historique': historyCtrl.text,
      'added_by':user["id"],
    };
    var res = await HistoryRequestManager.addHistory(data);
    if (res["type"] == "success") {
      if(mounted){
        Navigator.of(context).popUntil((route) => route.isFirst);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res['message'])));
      }

    } else {
      print(res["message"]);
    }

    setState(() {
      isLoading = false;
    });
  }
}

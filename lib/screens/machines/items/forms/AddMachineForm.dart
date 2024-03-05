import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomDropdown.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/ai/CameraScreen.dart';

class AddMachineForm extends StatefulWidget {
  const AddMachineForm({super.key});

  @override
  State<AddMachineForm> createState() => _AddMachineFormState();
}

class _AddMachineFormState extends State<AddMachineForm> {
  late String code = "";
  final _formKey = GlobalKey<FormState>();
  late TextEditingController codeCtrl;
  late Map<int, dynamic> chaines={};
  late Map<int, dynamic> parcs={};
  late Map<int, dynamic> refs={};
  late Map<int, dynamic> etats={};

  void _setCode(String value) {
    setState(() {
      codeCtrl = TextEditingController(text: value);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeCtrl = TextEditingController(text: code);
    chaines[0] = "CH17";
    chaines[1] = "CH18";
    chaines[2] = "CH19";
    refs[0] = "REF1";
    refs[1] = "REF2";
    refs[2] = "REF3";
    parcs[0] = "Parc stock";
    parcs[1] = "Parc occupé";
    etats[0] = "En marche";
    etats[1] = "En panne";
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.gear_solid,
                color: kPrimaryColor,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Ajouter une machine",
                style: kTitleTextStyle(
                    customFontSize:
                        width > kMobileWidth ? kTabletFont - 2 : kMobileFont),
              )
            ],
          ),
          SizedBox(
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
              refs.keys.isNotEmpty
                  ? CustomDropdown(items: refs, defaultItem: "ref2")
                  : const CircularProgressIndicator()
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
              CustomDropdown(items: etats, defaultItem: "En marche"),
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
              chaines.keys.isEmpty
                  ? const CircularProgressIndicator()
                  : CustomDropdown(items: chaines, defaultItem: "CH17"),
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
                  : CustomDropdown(items: parcs, defaultItem: "Parc stock"),
            ],
          ),
          const CustomSpacer(),
          MyActionButton(
            label: "Ajouter",
            color: kPrimaryColor,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')));
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
}

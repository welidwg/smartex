import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartex/Api/references/ReferencesRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/constants.dart';

class AddRefForm extends StatefulWidget {
  Function? updateView;

  AddRefForm({super.key, required this.updateView});

  @override
  State<AddRefForm> createState() => _AddRefFormState();
}

class _AddRefFormState extends State<AddRefForm> {
  TextEditingController reference = TextEditingController();
  ReferencesRequestManager manager = ReferencesRequestManager();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  _addRef(BuildContext context) async {
    Map<String, dynamic> data = {"ref": reference.text};
    var res = await manager.addRef(data);
    if (res["type"] == "success") {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res['message'])));
      setState(() {});
    } else {
      print(res['message']);
    }
    setState(() {
      isLoading = false;
    });
  }

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
                FontAwesomeIcons.asterisk,
                color: kPrimaryColor,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Ajouter des référence",
                style: kTitleTextStyle(
                    customFontSize:
                        width > kMobileWidth ? kTabletFont - 2 : kMobileFont),
              )
            ],
          ),
          const CustomSpacer(),
          Input(
            label: "Référence",
            is_Password: false,
            onChange: (value) {},
            controller: reference,
            message: "Veuillez saisir la référence",
          ),
          const SizedBox(
            height: 13,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(
                FontAwesomeIcons.infoCircle,
                size: 15,
                weight: 10,
                color: kPrimaryColor,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Text(
                      "Vous pouvez ajouter plusieurs références en les séparant par des virgules (ref1,ref2...)"))
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
                await _addRef(context);
                widget.updateView!();
              }
            },
          )
        ],
      ),
    );
  }
}

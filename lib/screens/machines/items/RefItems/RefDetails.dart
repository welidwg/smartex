import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartex/Api/references/ReferencesRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Loading.dart';
import 'package:smartex/components/Modals/ModalManager.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/machines/items/RefItems/LinkedMachines.dart';

class RefDetails extends StatefulWidget {
  late Map<String, dynamic> ref;
  final Function updateView;

  RefDetails({super.key, required this.ref, required this.updateView});

  @override
  State<RefDetails> createState() => _RefDetailsState();
}

class _RefDetailsState extends State<RefDetails> {
  late TextEditingController refCtrl;

  ReferencesRequestManager manager = ReferencesRequestManager();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refCtrl = TextEditingController(text: widget.ref['ref']);
  }

  @override
  Widget build(BuildContext context) {
    ModalManager modalManager = ModalManager();
    final double width = MediaQuery.of(context).size.width;
    return Column(
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
              "Référence : ${widget.ref["ref"]}",
              style: kTitleTextStyle(
                  customFontSize:
                      width > kMobileWidth ? kTabletFont - 2 : kMobileFont),
            )
          ],
        ),
        const CustomSpacer(),
        Input(
          controller: refCtrl,
          label: "Référence",
          is_Password: false,
          onChange: (value) {},
        ),
        const SizedBox(
          height: 13,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.solidEye,
              size: 15,
              weight: 10,
              color: kPrimaryColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: GestureDetector(
              onTap: () {
                print(widget.ref["machines"].length);
                modalManager.showModal(
                    content: LinkedMachines(ref: widget.ref), context: context);
              },
              child: const Text(
                "Voir les machines liées à cette référence",
                style: TextStyle(color: kPrimaryColor),
              ),
            ))
          ],
        ),
        const CustomSpacer(),
        isLoading
            ? Center(
                child: LoadingComponent(),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: MyActionButton(
                    label: "",
                    color: kPrimaryColor,
                    icon: Icons.save_as,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await _saveRefData(context);
                    },
                    isLoading: isLoading,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  MyActionButton(
                    label: "",
                    color: Colors.pink,
                    icon: Icons.delete_sweep,
                    isLoading: isLoading,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await _deleteRef(context);
                    },
                  )
                ],
              )
      ],
    );
    ;
  }

  _saveRefData(BuildContext context) async {
    Map<String, dynamic> data = {"id": widget.ref["id"], "ref": refCtrl.text};
    var res = await manager.editRef(data);
    if (res['type'] == "success") {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res['message'])));
      widget.updateView();
    } else {
      print(res['message']);
    }
    setState(() {
      isLoading = false;
    });
  }

  _deleteRef(BuildContext context) async {
    Map<String, dynamic> data = {
      "id": widget.ref["id"],
      "ref": widget.ref["ref"]
    };
    var res = await manager.deleteRef(data);
    if (res['type'] == "success") {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res['message'])));
      widget.updateView();
    } else {
      print(res['message']);
    }
    setState(() {
      isLoading = false;
    });
  }
}

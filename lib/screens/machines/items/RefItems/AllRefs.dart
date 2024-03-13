import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/Api/references/ReferencesRequestManager.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Loading.dart';
import 'package:smartex/components/Placeholders/ListPlaceHolder.dart';
import 'package:smartex/components/Title.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/ai/camera/CameraScreen.dart';
import 'package:smartex/screens/machines/items/MachineCard.dart';

class AllReferenceScreen extends StatefulWidget {
  late List<dynamic> refs;
  late Function updateView;

  AllReferenceScreen({super.key, required refs, required this.updateView});

  @override
  State<AllReferenceScreen> createState() => _AllReferenceScreenState();
}

class _AllReferenceScreenState extends State<AllReferenceScreen> {
  late TextEditingController codeCtrl;
  late List<dynamic> references = [];
  ReferencesRequestManager manager = ReferencesRequestManager();
  String search = '';
  bool isLoading = true;

  initRefs() async {
    references = await manager.getRefsList(search: search);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeCtrl = TextEditingController(text: "");
    initRefs();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const TitleComponent(
            title: "Tous les références", icon: CupertinoIcons.gear_solid),
        const CustomSpacer(),
        Input(
            controller: codeCtrl,
            vPadding: 0,
            hPadding: 7,
            suffixIc: GestureDetector(
              child: const Icon(
                Icons.search,
                size: 20,
              ),
              onTap: () {},
            ),
            label: "Référence",
            is_Password: false,
            onChange: (value) {
              setState(() {
                search = value;
                isLoading = true;
              });
              initRefs();
            }),
        const CustomSpacer(),
        Container(
          height: 300,
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
              ? const ListPlaceholder()
              : references.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text("Aucune référence trouvée"),
                      ],
                    )
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      //padding: EdgeInsets.only(bottom: 16),
                      children: references.map((e) {
                        return MachineCard(
                          type: "re",
                          item: e,
                          updateView: widget.updateView,
                        );
                      }).toList()),
        )
      ],
    );
  }
}

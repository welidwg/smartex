import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/Api/references/ReferencesRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Loading.dart';
import 'package:smartex/components/Modals/ModalContent.dart';
import 'package:smartex/components/Modals/ModalManager.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/machines/items/MachineCard.dart';
import 'package:smartex/screens/machines/items/RefItems/AllRefs.dart';
import 'package:smartex/screens/machines/items/forms/AddRefForm.dart';

class ReferencesList extends StatefulWidget {
  const ReferencesList({super.key});

  @override
  State<ReferencesList> createState() => _ReferencesListState();
}

class _ReferencesListState extends State<ReferencesList> {
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
    initRefs();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
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
                        Icons.text_snippet,
                        color: kPrimaryColor,
                      ),
                      Text(
                        "Réferences",
                        style: kTitleTextStyle(
                            customFontSize: width > kMobileWidth
                                ? kTabletFont
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
                        ModalManager.showModal(
                            content: AddRefForm(updateView: initRefs),
                            context: context);
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
                    vPadding: 0,
                    hPadding: 7,
                    label: "Références",
                    is_Password: false,
                    onChange: (value) {
                      setState(() {
                        search = value;
                      });
                      initRefs();
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
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingComponent(),
                  ],
                )
              : references.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Aucune référence trouvée"),
                      ],
                    )
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      //padding: EdgeInsets.only(bottom: 16),
                      children: references.map((e) {
                        return MachineCard(
                          type: "re",
                          item: e,
                          updateView: initRefs,
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
                onTap: () {
                  ModalManager.showModal(
                      content: AllReferenceScreen(
                        refs: references,
                        updateView: initRefs,
                      ),
                      context: context);
                },
                child: Text(
                  "Afficher tous",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize:
                          width > kMobileWidth ? kTabletFont : kMobileFont),
                ),
              ),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
        )
      ],
    );
  }
}

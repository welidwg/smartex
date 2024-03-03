import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/constants.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String defaultItem;

  const CustomDropdown(
      {super.key, required this.items, required this.defaultItem});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String selectedItem = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItem = widget.defaultItem;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19),
      decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor, width: 2),
          borderRadius: BorderRadius.circular(7)),
      child: DropdownButton(
          elevation: 0,
          dropdownColor: kSecondaryColor,
          style: const TextStyle(color: kPrimaryColor,fontFamily: "Font1"),
          borderRadius: BorderRadius.circular(10),
          isExpanded: true,
          value: selectedItem,
          onTap: () {
            setState(() {});
          },
          icon: const Icon(Icons.arrow_drop_down),
          items: widget.items.map<DropdownMenuItem<String>>((String? value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: width > kMobileWidth ? 18 : 13,
                    fontFamily: "Font1"),
              ),
            );
          }).toList(),
          onChanged: (String? newVal) {
            setState(() {
              selectedItem = newVal!;
            });
          }),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartex/constants.dart';

class Input extends StatefulWidget {
  late String label;
  late String? value;
  late bool is_Password;
  late Widget? suffixIc;
  late bool? isTextArea = false;
  late bool? isNumber = false;
  late double? vPadding;
  late double? hPadding;
  final Function(String value) onChange;
  final String? message;
  final TextEditingController? controller;

  Input(
      {super.key,
      required this.label,
      required this.is_Password,
      required this.onChange,
      this.isTextArea,
      this.value,
      this.vPadding,
      this.hPadding,
      this.suffixIc,
      this.message,
         this.controller,
      this.isNumber});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return TextFormField(
      onTapOutside: (e){
        FocusScope.of(context).unfocus();
      },

      cursorColor: kPrimaryColor,
      controller: widget.controller,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return widget.message ?? "erreur";
        }
        return null;
      },
      maxLines: widget.isTextArea != null ? null : 1,
      obscureText: widget.is_Password,
      style: TextStyle(
          color: kPrimaryColor,
          fontSize: width > kMobileWidth ? 18 : 13,
          fontFamily: "Font1",
          fontWeight: FontWeight.bold),
      onChanged: (value) {
        widget.onChange(value);
        setState(() {});
      },
      keyboardType: widget.isTextArea != null
          ? TextInputType.multiline
          : widget.isNumber == true
              ? TextInputType.number
              : TextInputType.emailAddress,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIc,
        suffixIconColor: kPrimaryColor,
        label: Text(widget.label,
            style: TextStyle(
                fontSize: width > kMobileWidth ? 18 : 13,
                color: kPrimaryColor,
                fontFamily: "Font1")),
        alignLabelWithHint: true,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        labelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        hintStyle: const TextStyle(color: kPrimaryColor),
        contentPadding: EdgeInsets.symmetric(
            vertical: widget.vPadding == null ? 22.0 : widget.vPadding!,
            horizontal: widget.hPadding == null ? 20.0 : widget.hPadding!),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
        ),
        errorStyle: const TextStyle(fontFamily: 'Font1',color: Colors.red,fontWeight: FontWeight.bold)
      ),
    );
  }
}

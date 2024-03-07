import 'package:flutter/cupertino.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/constants.dart';

class FormPlaceHolder extends StatelessWidget {
  const FormPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: width/2,child: kPlaceholder,),
        const CustomSpacer(),
        kPlaceholder,
        const SizedBox(height: 10,),
        kPlaceholder,
      ],
    );
  }
}

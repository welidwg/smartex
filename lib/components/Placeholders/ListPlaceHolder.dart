import 'package:flutter/cupertino.dart';
import 'package:smartex/components/CustomSpacer.dart';
import 'package:smartex/constants.dart';

class ListPlaceholder extends StatelessWidget {
  const ListPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          kPlaceholder,
          const SizedBox(height: 10,),
          kPlaceholder,
          const SizedBox(height: 10,),
          kPlaceholder,
          const SizedBox(height: 10,),
          kPlaceholder,
        ],
      ),
    );
  }
}

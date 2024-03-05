import 'package:flutter/cupertino.dart';
import 'package:smartex/constants.dart';

class TitleComponent extends StatefulWidget {
  final String title;
  final IconData icon;

  const TitleComponent({super.key, required this.title, required this.icon});

  @override
  State<TitleComponent> createState() => _TitleComponentState();
}

class _TitleComponentState extends State<TitleComponent> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          widget.icon,
          color: kPrimaryColor,
          size: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          widget.title,
          style: kTitleTextStyle(
              customFontSize:
                  width > kMobileWidth ? kTabletFont - 2 : kMobileFont),
        )
      ],
    );
  }
}

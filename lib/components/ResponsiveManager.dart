import 'package:flutter/cupertino.dart';
import 'package:smartex/constants.dart';

class ResponsiveManager {
  static double setFont(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double fontSize = width > kMobileWidth ? kTabletFont : kMobileFont;
    return fontSize;
  }
}

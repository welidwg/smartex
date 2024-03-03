import 'package:flutter/cupertino.dart';
import 'package:smartex/constants.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileBody;
  final Widget desktopBody;
  const ResponsiveLayout({Key? key,required this.desktopBody,required this.mobileBody}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: LayoutBuilder(
          builder: (context,constraints){
        if(constraints.maxWidth<kMobileWidth){
          return widget.mobileBody;
        }else{
          return widget.desktopBody;
        }
      }),
    );
  }
}

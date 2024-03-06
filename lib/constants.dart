import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

const  kPrimaryColor=Color(0xFF27306D);
const  kSecondaryColor=Color(0xFFDEE0ED);
Image kLogo=Image.asset("images/logo.png");
Hero kLogoL=  Hero(
    tag: "logo",
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(width: 350,height: 350,child: kLogo),
    ));
const double kMobileWidth=600;
Hero kLogoS=  Hero(
    tag: "logo",
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(width: 250,height: 250,child: kLogo),
    ));

Hero kLogoXS({double cWidth = 200})=>  Hero(
    tag: "logo",
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(width: cWidth,child: kLogo),
    ));


double kMobileFont=15;
double kMobileTitleFont=20;
double kTabletFont=20 ;
double kTabletTitleFont=25;

TextStyle kActive=const TextStyle(fontWeight: FontWeight.bold,color: kPrimaryColor,fontFamily: "Font1");
TextStyle kInActive=const TextStyle(fontWeight: FontWeight.normal,color: Colors.black,fontFamily: "Font1");

TextStyle kTitleTextStyle({double customFontSize=10})=>TextStyle(
  fontSize:customFontSize,
  color: kPrimaryColor,
  fontWeight: FontWeight.bold
);
TextStyle kContentTextStyle({double customFontSize=10})=>TextStyle(
    fontSize:customFontSize,
    color: kPrimaryColor,
);
String kUrlLaravel="http://192.168.1.16:8000/api";

Widget kPlaceholder=SizedBox(
  child: Shimmer.fromColors(
      baseColor: Colors.white10,
      highlightColor: kSecondaryColor,
      child: Container(
        height: 40,
        decoration:  BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(10)
        ),
      )),
);
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

const kPrimaryColor = Color(0xFF27306D);
const kSecondaryColor = Color(0xFFDEE0ED);
Image kLogo = Image.asset("images/logos/s2.png");
Image kLogo1 = Image.asset("images/logos/s1.png");
Image kLogo2 = Image.asset("images/logos/main11.png");
Image kLogo3 = Image.asset("images/logos/main22.png");
Hero kLogoL = Hero(
    tag: "logo",
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(width: 350, height: 350, child: kLogo),
    ));
const double kMobileWidth = 600;
Hero kLogoS = Hero(
    tag: "logo",
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(width: 250, height: 250, child: kLogo),
    ));

Hero kLogoXS({double cWidth = 200}) => Hero(
    tag: "logo",
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          //SizedBox(width: cWidth, child: kLogo),
          SizedBox(width: cWidth, child: kLogo),
        ],
      ),
    ));
Hero kLogoPrimaryXS({double cWidth = 300}) => Hero(
    tag: "logo",
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          //SizedBox(width: cWidth, child: kLogo),
          SizedBox(width: cWidth, child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: kLogo1,
          )),
        ],
      ),
    ));

Hero kLogoSecondaryXS({double cWidth = 300}) => Hero(
    tag: "logo",
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          //SizedBox(width: cWidth, child: kLogo),
          SizedBox(width: cWidth, child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: kLogo3,
          )),
        ],
      ),
    ));

double kMobileFont = 15;
double kMobileTitleFont = 20;
double kTabletFont = 20;

double kTabletTitleFont = 25;

TextStyle kActive = const TextStyle(
    fontWeight: FontWeight.bold, color: kPrimaryColor, fontFamily: "Font1");
TextStyle kInActive = const TextStyle(
    fontWeight: FontWeight.normal, color: Colors.black, fontFamily: "Font1");

TextStyle kTitleTextStyle({double customFontSize = 10}) => TextStyle(
    fontSize: customFontSize,
    color: kPrimaryColor,
    fontWeight: FontWeight.bold);

TextStyle kContentTextStyle({double customFontSize = 10}) => TextStyle(
      fontSize: customFontSize,
      color: kPrimaryColor,
    );
String kUrlLaravel = "http://192.168.1.16:8000/api";
String kUrlFlask = "http://192.168.1.16:5000";

Widget kPlaceholder = SizedBox(
  child: Shimmer.fromColors(
      baseColor: Colors.white10,
      highlightColor: kSecondaryColor,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(10)),
      )),
);

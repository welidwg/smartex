import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/Cards/Card.dart';
import 'package:smartex/components/TopBar.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/responsive/responsive_layout.dart';
import 'package:smartex/screens/home/MobileHome.dart';
import 'package:smartex/screens/home/TabletHome.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static final id = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime today = DateTime.now();

  Future<DateTime> _getCurrentTime() async {
    return DateTime.now();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    today = DateTime.now();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        today = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child:  SingleChildScrollView(
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        CustomCard(
                          width: width > kMobileWidth ? width / 2 : 200,
                          content: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.supervised_user_circle,
                                color: kPrimaryColor,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Username | Admin",
                                style: kContentTextStyle(
                                    customFontSize:
                                        width > kMobileWidth ? kTabletFont : kMobileFont).copyWith(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: CustomCard(
                              content: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    color: kPrimaryColor,
                                    Icons.calendar_today,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      "${today.day}/${today.month}/${today.year}",
                                      style: kContentTextStyle(
                                          customFontSize: width > kMobileWidth
                                              ? kTabletFont
                                              : kMobileFont).copyWith(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_outlined,
                                    size: 20,
                                    color: kPrimaryColor,

                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${today.hour}:${today.minute < 10 ? '0${today.minute}' : today.minute}",
                                    style: kContentTextStyle(
                                        customFontSize: width > kMobileWidth
                                            ? kTabletFont
                                            : kMobileFont).copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomCard(
                  width:  width,
                  content: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0),
                            foregroundColor:
                                MaterialStateProperty.all(kPrimaryColor)),
                        child: Text(
                          "Equilibrage",
                          style: kTitleTextStyle(
                              customFontSize:
                                  width > kMobileWidth ? kTabletFont : kMobileFont+2),
                        ),
                      ))
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    const Icon(Icons.ssid_chart, color: kPrimaryColor),
                    Text(
                      "Statistiques du jour",
                      style: kTitleTextStyle(
                          customFontSize:
                              width > kMobileWidth ? kTabletFont : kMobileTitleFont).copyWith(color: kPrimaryColor),
                    ),

                  ],
                ),
                SizedBox(height: 12,),
                 // CustomCard(
                 //   width: width>kMobileWidth ? width/2 : width,
                 //     content:   Text("charged")),

                 ResponsiveLayout(
                  desktopBody: TabletHome(width: width,),
                  mobileBody: MobileHome(width: width,),
                ),
              ],
            ),
          ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:smartex/Api/users/UsersRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/ResponsiveManager.dart';
import 'package:smartex/components/TopBar.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/home/HomeScreen.dart';
import 'package:smartex/screens/login/LoginScreen.dart';
import 'package:smartex/screens/machines/MachinesScreen.dart';
import 'package:smartex/screens/notification/NotificationScreen.dart';
import 'package:smartex/screens/notification/NotificationService.dart';
import 'package:smartex/screens/users/UsersScreen.dart';
import 'package:smartex/storage/LocalStorage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String id = "main_screen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool updateView = false;
  Widget currentPage = const HomeScreen();
  UsersRequestManager manager = UsersRequestManager();
  late PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  late Map<String, dynamic> user;

  void onError(String message, int? code, dynamic e) {
    print("onError: $message code: $code exception: $e");
  }

  void ReceivedNotif(PusherEvent event) async {
    if (jsonEncode(event.data).toString() != "{}") {
      var data = jsonDecode(event.data);
      await NotificationService(redirect: (String route) {
        Navigator.pushNamed(context, route);
      }).showNotification(title: data["title"], body: data["content"]);
      if (currentPage.runtimeType == NotificationScreen) {
        setState(() {
          currentPage = KeyedSubtree(
            key: Key("${UniqueKey()}"),
            child: const NotificationScreen(),
          );
        });
      }
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print("onSubscriptionSucceeded: $channelName data: $data");
  }

  void initPusher() async {
    user = await LocalStorage.getUser();

    await pusher.init(
      apiKey: "d434bf4ee07c17bd7135",
      cluster: "eu",
      onError: onError,
      onEvent: ReceivedNotif,
      onSubscriptionSucceeded: onSubscriptionSucceeded,
    );
    await pusher.subscribe(channelName: "notif${user["role"]["id"]}");
    await pusher.connect();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pusher.disconnect();
    super.dispose();
  }

  void refreshView() {
    setState(() {
      updateView = !updateView;
    });
  }

  updater(screen) {
    setState(() {
      currentPage = screen;
      //Navigator.pop(context);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPusher();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        bool test = false;
        showDialog(
            context: context,
            builder: ((context) {
              return CupertinoAlertDialog(
                title: const Text("Confirmation"),
                content: const Text("Voulez-vous déconnecter ?"),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text(
                      'Annuler',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text(
                      'Déconnexion',
                      style: TextStyle(color: Colors.pink),
                    ),
                    onPressed: () async {
                      //Navigator.of(context).pop();
                      test = true;
                      await UsersRequestManager.logoutUser();
                      Navigator.pushReplacementNamed(context, LoginSreen.id);
                    },
                  ),
                ],
              );
            }));

        return test;
      },
      child: Scaffold(
        drawer: Drawer(
            width: width > kMobileWidth ? width / 3 - 100 : width,
            child: Container(
              height: height,
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: DrawerHeader(
                        decoration: const BoxDecoration(color: kPrimaryColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [kLogoPrimaryXS(cWidth: 100)],
                            ),
                            Text(
                              "Smartex",
                              style: GoogleFonts.alice(
                                  color: Colors.white,
                                  fontSize: width > kMobileWidth ? 30 : 27,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  color: CupertinoColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 2,
                                        blurStyle: BlurStyle.normal,
                                        offset: const Offset(0, 1),
                                        spreadRadius: 0.4)
                                  ]),
                              child: ListTile(
                                selected: currentPage.runtimeType == HomeScreen,
                                selectedColor: kPrimaryColor,
                                leading: const Icon(Icons.house),
                                title: Text(
                                  'Accueil',
                                  style: TextStyle(
                                      fontFamily: "Font1",
                                      fontWeight: currentPage.runtimeType ==
                                          HomeScreen
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                onTap: () {
                                  setState(() {
                                    currentPage = const HomeScreen();
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  color: CupertinoColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 2,
                                        blurStyle: BlurStyle.normal,
                                        offset: const Offset(0, 1),
                                        spreadRadius: 0.4)
                                  ]),
                              child: ListTile(
                                selected:
                                    currentPage.runtimeType == UsersScreen,
                                selectedColor: kPrimaryColor,
                                leading: const Icon(
                                    Icons.supervised_user_circle_outlined),
                                title: Text(
                                  'Utilisateurs',
                                  style: TextStyle(
                                      fontFamily: "Font1",
                                      fontWeight: currentPage.runtimeType ==
                                          UsersScreen
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                onTap: () {
                                  setState(() {
                                    currentPage = UsersScreen(
                                      width: width,
                                      updateView: refreshView,
                                    );
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  color: CupertinoColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 2,
                                        blurStyle: BlurStyle.normal,
                                        offset: Offset(0, 1),
                                        spreadRadius: 0.4)
                                  ]),
                              child: ListTile(
                                leading:
                                    const Icon(CupertinoIcons.gear_alt_fill),
                                selected:
                                    currentPage.runtimeType == MachinesScreen,
                                selectedColor: kPrimaryColor,
                                title: Text(
                                  'Machines',
                                  style: TextStyle(
                                      fontFamily: "Font1",
                                      fontWeight: currentPage.runtimeType ==
                                              MachinesScreen
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                onTap: () {
                                  setState(() {
                                    currentPage = const MachinesScreen();
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyActionButton(
                            label: "Déconnexion",
                            color: kPrimaryColor,
                            icon: Icons.logout,
                            onPressed: () async {
                              await UsersRequestManager.logoutUser();
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginSreen.id);
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              TopBar(updater: updater),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                      color: CupertinoColors.white,
                      width: width,
                      height:
                          width > kMobileWidth ? height - 100 : height - 150,
                      child: currentPage),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

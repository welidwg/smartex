import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/Api/users/UsersRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/TopBar.dart';
import 'package:smartex/constants.dart';
import 'package:smartex/screens/home/HomeScreen.dart';
import 'package:smartex/screens/login/LoginScreen.dart';
import 'package:smartex/screens/machines/MachinesScreen.dart';
import 'package:smartex/screens/users/UsersScreen.dart';

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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            kLogoSecondaryXS(
                                cWidth: width > kMobileWidth ? 160 : 250)
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
                                leading: const Icon(Icons.house),
                                title: Text('Accueil',
                                    style: currentPage.toString() ==
                                            const HomeScreen().toString()
                                        ? kActive
                                        : kInActive),
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
                                leading: const Icon(
                                    Icons.supervised_user_circle_outlined),
                                title: Text(
                                  'Utilisateurs',
                                  style: currentPage.toString() ==
                                          UsersScreen().toString()
                                      ? kActive
                                      : kInActive,
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
                                leading: const Icon(CupertinoIcons.gear_big),
                                title: Text(
                                  'Machines',
                                  style: currentPage.toString() ==
                                          const MachinesScreen().toString()
                                      ? kActive
                                      : kInActive,
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
                      height: width > kMobileWidth ? height : height - 150,
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

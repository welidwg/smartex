import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:smartex/screens/MainScreen.dart';
import 'package:smartex/screens/ai/camera/CameraScreen.dart';
import 'package:smartex/screens/home/HomeScreen.dart';
import 'package:smartex/screens/login/LoginScreen.dart';
import 'package:smartex/screens/SplashScreen.dart';
import 'package:smartex/screens/notification/NotificationService.dart';
import 'package:smartex/screens/users/UsersScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService(redirect: (String value) {}).initNotification();
  FlutterBackground.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smartex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontFamily: "Font1"),
            labelLarge: TextStyle(fontFamily: "Font1"),
            displayLarge: TextStyle(fontFamily: "Font1"),
          )),
      home: const SplashScreen(),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        LoginSreen.id: (context) => const LoginSreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        MainScreen.id: (context) => const MainScreen(),
        UsersScreen.id: (context) => UsersScreen(),
        CameraScreen.id: (context) => CameraScreen(),
      },
    );
  }
}

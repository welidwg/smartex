import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  static Future<Map<String, dynamic>> getUser() async {
    var user = await storage.read(key: "user");
    return json.decode(user!);
  }

  static Future<bool> checkAuth() async{
    var token =await storage.read(key: "token");
    if (token==null) {
      return false;
    }
    return true;
  }
  static flashSession()async{
    await storage.delete(key: "token");
    await storage.delete(key: "user");
  }
}

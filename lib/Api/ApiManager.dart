import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartex/constants.dart';
import 'package:http/http.dart' as http;
import 'package:smartex/storage/LocalStorage.dart';

class ApiManager {
  late String url;
  late String csrf = '';
  final storage = const FlutterSecureStorage();

  ApiManager({required this.url});

  Future<Map<String, dynamic>> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    var link = Uri.parse('$url/$endpoint');
    var jsonData = jsonEncode(data);
    try {
      var response = await http.post(link,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (error) {
      return {'message': error};
    }
  }

  Future<Map<String, dynamic>> sendRequest(
      String method, String endpoint, Map<String, dynamic> data) async {
    var token = await LocalStorage.getToken();
    var link = Uri.parse('$url/$endpoint');
    var jsonData = jsonEncode(data);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token == null ? "" : "Bearer ${token.toString()}"
    };
    late http.Response response;
    switch (method.toLowerCase()) {
      case "post":
        response = await http.post(link, headers: headers, body: jsonData);
        break;
      case "get":
        response = await http.get(
          link,
          headers: headers,
        );
        break;
      case "put":
        response = await http.put(link, headers: headers, body: jsonData);
        break;
      case "delete":
        response = await http.delete(link, headers: headers, body: jsonData);
        break;
      default:
        throw Exception('Méthode HTTP non prise en charge : $method');
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body.toString());
    }
  }

  Future<List<dynamic>> getRequestList(
      String endpoint, Map<String, dynamic>? data) async {
    var token = await LocalStorage.getToken();
    var link = Uri.parse('$url/$endpoint');
    var jsonData = jsonEncode(data);
    try {
      var response = await http.get(link, headers: {
        'Content-Type': 'application/json',
        'Authorization': token == null ? "" : "Bearer ${token.toString()}"
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        print('Erreur lors de la requête 1: ${response.statusCode}');
        return [];
      }
    } catch (erreur) {
      print('Erreur lors de la requête : $erreur');
      return [];
    }
  }

  Future<Map<String, dynamic>> getRequest(
      String endpoint, Map<String, dynamic>? data) async {
    var link = Uri.parse('$url/$endpoint');
    var jsonData = jsonEncode(data);
    try {
      var response =
          await http.get(link, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        print('Erreur lors de la requête 1: ${response.statusCode}');
        return {};
      }
    } catch (erreur) {
      print('Erreur lors de la requête : $erreur');
      return {};
    }
  }
}

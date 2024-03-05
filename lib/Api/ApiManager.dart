import 'dart:convert';

import 'package:smartex/constants.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  late String url;
  late String csrf = '';

  ApiManager({required this.url});

  getCsrfToken() async {
    await getRequest("csrf", null).then((value) {
      csrf = value["token"];
    });
    print(csrf);
  }

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
    var link = Uri.parse('$url/$endpoint');
    var jsonData = jsonEncode(data);
    late var response;
    switch (method.toLowerCase()) {
      case "post":
        response = await http.post(link,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonData);
        break;
      case "get":
        response = await http.get(
          link,
          headers: {
            'Content-Type': 'application/json',
          },
        );
        break;
      case "put":
        response = await http.put(link,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonData);
        break;
      case "delete":
        response = await http.delete(link,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonData);
        break;
      default:
        throw Exception('Méthode HTTP non prise en charge : $method');
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }

  }



  Future<List<dynamic>> getRequestList(
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

import 'package:smartex/constants.dart';
import 'package:smartex/storage/LocalStorage.dart';

import '../ApiManager.dart';

class NotificationRequestManager {
  static ApiManager manager = ApiManager(url: kUrlLaravel);
  static String suffix = "notification";

  static Future<List<dynamic>> getNotification(
      Map<String, dynamic> data) async {
    var user = await LocalStorage.getUser();
    var test = await manager
        .getRequestList("$suffix/getByRole/${user["role"]["id"]}", {});
    return test;
  }

  static Future<Map<String, dynamic>> delete(int id) async {
    return await manager.sendRequest("delete", "$suffix/$id", {});
  }
}

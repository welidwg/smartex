import 'package:smartex/Api/ApiManager.dart';
import 'package:smartex/constants.dart';

class HistoryRequestManager {
  static ApiManager manager = ApiManager(url: kUrlLaravel);
  static String suffix = "historique";

  static Future<Map<String, dynamic>> addHistory(Map<String, dynamic> data) async {
    return await manager.sendRequest("post", suffix, data);
  }
  static Future<Map<String, dynamic>> getEstimation(Map<String, dynamic> data) async {
    return await manager.sendRequest("get","estimate/${data["id_machine"]}", data);
  }
}

import 'package:smartex/Api/ApiManager.dart';
import 'package:smartex/constants.dart';

class RolesRequestManager{
  static ApiManager manager = ApiManager(url: kUrlLaravel);
  static String suffix="role";
  Future<Map<String, dynamic>> addRole(Map<String,dynamic> data)async{
    return await manager.sendRequest("post",suffix, data);
  }

  Future<Map<String, dynamic>> editRole(Map<String,dynamic> data)async{
    return await manager.sendRequest("put","$suffix/${data["id"]}", data);
  }
  Future<Map<String, dynamic>> deleteRole(Map<String,dynamic> data)async{
    return await manager.sendRequest("delete","$suffix/${data["id"]}", data);
  }
  static Future<List<dynamic>> getRolesList({String? search})async{
    return await manager.getRequestList("$suffix?search=$search", null);
  }
}
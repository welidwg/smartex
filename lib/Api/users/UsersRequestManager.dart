import 'package:smartex/Api/ApiManager.dart';
import 'package:smartex/constants.dart';

class UsersRequestManager{
  ApiManager manager = ApiManager(url: kUrlLaravel);

  Future<List<dynamic>> getUsersList({String? search})async{
    return await manager.getRequestList("utilisateur?search=$search", null);
  }
  Future<Map<String, dynamic>> addUser(Map<String,dynamic> data)async{
    return await manager.sendRequest("post","utilisateur", data);
  }
  Future<Map<String, dynamic>> editUser(Map<String,dynamic> data)async{
    return await manager.sendRequest("put","utilisateur/${data["id"]}",data);
  }

  Future<Map<String, dynamic>> deleteUser(Map<String,dynamic> data)async{
    return await manager.sendRequest("delete","utilisateur/${data["id"]}",data);
  }
}
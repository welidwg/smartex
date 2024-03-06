import 'package:smartex/Api/ApiManager.dart';
import 'package:smartex/constants.dart';

class ReferencesRequestManager{
  ApiManager manager = ApiManager(url: kUrlLaravel);
  Future<Map<String, dynamic>> addRef(Map<String,dynamic> data)async{
    return await manager.sendRequest("post","reference", data);
  }

  Future<Map<String, dynamic>> editRef(Map<String,dynamic> data)async{
    return await manager.sendRequest("put","reference/${data["id"]}", data);
  }
  Future<Map<String, dynamic>> deleteRef(Map<String,dynamic> data)async{
    return await manager.sendRequest("delete","reference/${data["id"]}", data);
  }
  Future<List<dynamic>> getRefsList({String? search})async{
    return await manager.getRequestList("reference?search=$search", null);
  }
}
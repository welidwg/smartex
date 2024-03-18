import 'package:smartex/Api/ApiManager.dart';
import 'package:smartex/constants.dart';

class MachinesRequestManager{
  static ApiManager manager = ApiManager(url: kUrlLaravel);

  Future<List<dynamic>> getMachinesList({String? search})async{
    return await manager.getRequestList("machine?search=$search", null);
  }
  Future<Map<String, dynamic>> addMachines(Map<String,dynamic> data)async{
    return await manager.sendRequest("post","machine", data);
  }
  Future<Map<String, dynamic>> editMachines(Map<String,dynamic> data)async{
    return await manager.sendRequest("put","machine/${data["id"]}",data);
  }

  Future<Map<String, dynamic>> deleteMachines(Map<String,dynamic> data)async{
    return await manager.sendRequest("delete","machine/${data["id"]}",data);
  }

  static Future<Map<String, dynamic>> echangeMachine(Map<String,dynamic> data)async{
    return await manager.sendRequest("post","echange",data);
  }

  static Future<Map<String, dynamic>> cancelExchange(Map<String,dynamic> data)async{
    return await manager.sendRequest("put","echange/${data["id"]}",data);
  }
}
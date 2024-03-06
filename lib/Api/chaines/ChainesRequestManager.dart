import 'package:smartex/Api/ApiManager.dart';
import 'package:smartex/constants.dart';

class ChainesRequestManager{
  ApiManager manager = ApiManager(url: kUrlLaravel);
  Future<List<dynamic>> getChainesList({String? search})async{
    return await manager.getRequestList("chaine?search=$search", null);
  }

}

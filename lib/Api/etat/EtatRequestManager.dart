import 'package:smartex/Api/ApiManager.dart';
import 'package:smartex/constants.dart';

class EtatRequestManager{
  ApiManager manager = ApiManager(url: kUrlLaravel);
  Future<List<dynamic>> getEtatList({String? search})async{
    return await manager.getRequestList("etat?search=$search", null);
  }

}

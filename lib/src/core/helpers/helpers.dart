import 'package:pagination/src/core/utils/constants/network_constant.dart';
import 'package:pagination/src/core/utils/injections.dart';
import 'package:pagination/src/shared/data/data_source/app_shared_prefs.dart';

class Helpers{

  static String dateFormat( DateTime? date ){
    if( date != null ){
      return '${date.year} ${ date.month } ${ date.day }';
    }else{
      return 'No date';
    }
  }


  static Map<String,String> getHeaders(){
    return {
      'accept': 'application/json',
      'Authorization' : 'Bearer ${ getKeyTmdb() }'
    };
  }

  static String getLastSync() {
    return sl<AppSharedPrefs>().lastSync;
  }

}
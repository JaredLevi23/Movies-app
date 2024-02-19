import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs {
  final SharedPreferences _preferences;

  AppSharedPrefs(this._preferences);

  String get lastSync{
    return _preferences.getString('last-sync') ?? '';
  }

  set lastSync( String lastSync ){
    _preferences.setString('last-sync', lastSync );
  }

}

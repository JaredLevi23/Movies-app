
import 'package:connectivity_plus/connectivity_plus.dart';

class Validators{

  Future<bool?> hasConnection() async {
    final connectivity = await Connectivity().checkConnectivity();
    switch (connectivity) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.none:
        return false;
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.other:
      case ConnectivityResult.vpn:
        return null;
    }
  }

}
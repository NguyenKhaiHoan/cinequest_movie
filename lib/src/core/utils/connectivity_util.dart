import 'package:cinequest/src/external/services/connectivity/connectivity_service.dart';

import '../injection_container.dart';

class ConnectivityUtil {
  ConnectivityUtil._();

  static Future<bool> checkConnectivity() async {
    final connectivityService = sl<ConnectivityService>();
    return await connectivityService.isConnected();
  }
}

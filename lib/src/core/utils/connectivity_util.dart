import '../../common/bloc/connectivity/connectivity_bloc.dart';
import '../injection_container.dart';

class ConnectivityUtil {
  ConnectivityUtil._();

  static bool checkConnectivity() {
    final connectivityState = sl<ConnectivityBloc>().state;

    var isConnected = false;
    connectivityState.whenOrNull(success: (value) => isConnected = value);
    return isConnected;
  }
}

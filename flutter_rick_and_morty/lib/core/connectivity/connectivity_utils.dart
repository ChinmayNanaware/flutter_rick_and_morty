import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtils {
  static Future<bool> isConnected() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  static StreamSubscription<ConnectivityResult> monitorNetworkChanges({
    required Function(ConnectivityResult) onConnectivityChanged,
  }) {
    final streamSubscription = Connectivity().onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        // Alert if disconnected
        // Replace with your preferred alert mechanism
      } else {
        onConnectivityChanged(connectivityResult);
      }
    });
    return streamSubscription;
  }
}

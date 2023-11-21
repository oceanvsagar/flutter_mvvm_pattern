import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ekam_flutter_assignment/utils/utils.dart';

class AppConnectivity {
  AppConnectivity._();

  static AppConnectivity? _singleton;

  factory AppConnectivity() {
    _singleton ??= AppConnectivity._();
    return _singleton!;
  }

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> init() async {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (await _connectivity.checkConnectivity() != ConnectivityResult.none) {
      _isConnected = true;
    }
  }

  bool _isConnected = false;

  bool get isConnected {
    return _isConnected;
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _isConnected = (result != ConnectivityResult.none);
  }

  void dispose() {
    try {
      _connectivitySubscription.cancel();
    } catch (e) {
      Utils.printCrashError(e.toString());
    }
  }
}

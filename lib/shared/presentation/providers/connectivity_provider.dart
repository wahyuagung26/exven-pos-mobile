import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus {
  online,
  offline,
  checking;

  bool get isConnected => this == ConnectivityStatus.online;
  bool get isDisconnected => this == ConnectivityStatus.offline;
  bool get isChecking => this == ConnectivityStatus.checking;
}

class ConnectivityState {
  final ConnectivityStatus status;
  final ConnectivityResult connectionType;
  final DateTime? lastConnected;
  final DateTime? lastChecked;
  final String? error;

  const ConnectivityState({
    required this.status,
    required this.connectionType,
    this.lastConnected,
    this.lastChecked,
    this.error,
  });

  bool get isConnected => status.isConnected;
  bool get isDisconnected => status.isDisconnected;
  bool get isChecking => status.isChecking;

  bool get isWifi => connectionType == ConnectivityResult.wifi;
  bool get isMobile => connectionType == ConnectivityResult.mobile;
  bool get isEthernet => connectionType == ConnectivityResult.ethernet;
  bool get hasLimitedConnection => isMobile;

  ConnectivityState copyWith({
    ConnectivityStatus? status,
    ConnectivityResult? connectionType,
    DateTime? lastConnected,
    DateTime? lastChecked,
    String? error,
  }) {
    return ConnectivityState(
      status: status ?? this.status,
      connectionType: connectionType ?? this.connectionType,
      lastConnected: lastConnected ?? this.lastConnected,
      lastChecked: lastChecked ?? this.lastChecked,
      error: error ?? this.error,
    );
  }
}

class ConnectivityNotifier extends StateNotifier<ConnectivityState> {
  final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult>? _subscription;
  Timer? _checkTimer;

  ConnectivityNotifier(this._connectivity)
      : super(const ConnectivityState(
          status: ConnectivityStatus.checking,
          connectionType: ConnectivityResult.none,
        )) {
    _init();
  }

  Future<void> _init() async {
    await _checkConnectivity();
    _listenToConnectivityChanges();
    _startPeriodicChecks();
  }

  void _listenToConnectivityChanges() {
    _subscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) {
        _updateConnectionType(result);
        _checkInternetAccess();
      },
      onError: (error) {
        state = state.copyWith(
          status: ConnectivityStatus.offline,
          error: error.toString(),
          lastChecked: DateTime.now(),
        );
      },
    );
  }

  void _startPeriodicChecks() {
    _checkTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (state.isConnected) {
        _checkInternetAccess();
      }
    });
  }

  Future<void> _checkConnectivity() async {
    try {
      state = state.copyWith(status: ConnectivityStatus.checking);
      
      final result = await _connectivity.checkConnectivity();
      _updateConnectionType(result);
      
      await _checkInternetAccess();
    } catch (error) {
      state = state.copyWith(
        status: ConnectivityStatus.offline,
        error: error.toString(),
        lastChecked: DateTime.now(),
      );
    }
  }

  void _updateConnectionType(ConnectivityResult result) {
    state = state.copyWith(
      connectionType: result,
      lastChecked: DateTime.now(),
    );
  }

  Future<void> _checkInternetAccess() async {
    if (state.connectionType == ConnectivityResult.none) {
      state = state.copyWith(
        status: ConnectivityStatus.offline,
        lastChecked: DateTime.now(),
      );
      return;
    }

    try {
      final result = await InternetAddress.lookup('google.com');
      
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final now = DateTime.now();
        state = state.copyWith(
          status: ConnectivityStatus.online,
          lastConnected: now,
          lastChecked: now,
          error: null,
        );
      } else {
        state = state.copyWith(
          status: ConnectivityStatus.offline,
          lastChecked: DateTime.now(),
        );
      }
    } catch (error) {
      state = state.copyWith(
        status: ConnectivityStatus.offline,
        error: error.toString(),
        lastChecked: DateTime.now(),
      );
    }
  }

  Future<void> refresh() async {
    await _checkConnectivity();
  }

  Future<bool> checkConnection() async {
    await _checkConnectivity();
    return state.isConnected;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _checkTimer?.cancel();
    super.dispose();
  }
}

final connectivityProvider = StateNotifierProvider<ConnectivityNotifier, ConnectivityState>((ref) {
  return ConnectivityNotifier(Connectivity());
});

final isConnectedProvider = Provider<bool>((ref) {
  final connectivityState = ref.watch(connectivityProvider);
  return connectivityState.isConnected;
});

final connectionTypeProvider = Provider<ConnectivityResult>((ref) {
  final connectivityState = ref.watch(connectivityProvider);
  return connectivityState.connectionType;
});

final hasLimitedConnectionProvider = Provider<bool>((ref) {
  final connectivityState = ref.watch(connectivityProvider);
  return connectivityState.hasLimitedConnection;
});

final connectivityStatusProvider = Provider<ConnectivityStatus>((ref) {
  final connectivityState = ref.watch(connectivityProvider);
  return connectivityState.status;
});

final lastConnectedProvider = Provider<DateTime?>((ref) {
  final connectivityState = ref.watch(connectivityProvider);
  return connectivityState.lastConnected;
});

final connectivityErrorProvider = Provider<String?>((ref) {
  final connectivityState = ref.watch(connectivityProvider);
  return connectivityState.error;
});

final networkAwareProvider = Provider.family<bool, bool>((ref, requireUnlimitedConnection) {
  final connectivityState = ref.watch(connectivityProvider);
  
  if (!connectivityState.isConnected) {
    return false;
  }
  
  if (requireUnlimitedConnection && connectivityState.hasLimitedConnection) {
    return false;
  }
  
  return true;
});

extension ConnectivityStateExtensions on ConnectivityState {
  String get displayName {
    switch (status) {
      case ConnectivityStatus.online:
        return 'Connected';
      case ConnectivityStatus.offline:
        return 'Offline';
      case ConnectivityStatus.checking:
        return 'Checking...';
    }
  }

  String get connectionTypeDisplayName {
    switch (connectionType) {
      case ConnectivityResult.wifi:
        return 'Wi-Fi';
      case ConnectivityResult.mobile:
        return 'Mobile Data';
      case ConnectivityResult.ethernet:
        return 'Ethernet';
      case ConnectivityResult.bluetooth:
        return 'Bluetooth';
      case ConnectivityResult.vpn:
        return 'VPN';
      case ConnectivityResult.other:
        return 'Other';
      case ConnectivityResult.none:
      default:
        return 'No Connection';
    }
  }

  Duration? get timeSinceLastConnected {
    if (lastConnected == null) return null;
    return DateTime.now().difference(lastConnected!);
  }

  Duration? get timeSinceLastChecked {
    if (lastChecked == null) return null;
    return DateTime.now().difference(lastChecked!);
  }

  bool get wasRecentlyConnected {
    final timeSince = timeSinceLastConnected;
    return timeSince != null && timeSince.inMinutes < 5;
  }

  String? get statusMessage {
    if (isConnected) {
      return 'Connected via ${connectionTypeDisplayName.toLowerCase()}';
    }
    
    if (error != null) {
      return 'Connection error: $error';
    }
    
    if (wasRecentlyConnected) {
      return 'Recently disconnected';
    }
    
    return 'No internet connection';
  }
}
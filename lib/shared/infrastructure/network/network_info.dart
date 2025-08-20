import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

/// Network connectivity status
enum NetworkStatus {
  /// Connected to mobile network
  mobile,
  
  /// Connected to WiFi network
  wifi,
  
  /// Connected to Ethernet (desktop/web)
  ethernet,
  
  /// No network connection
  offline,
  
  /// Unknown connection status
  unknown,
}

/// Network information and connectivity monitoring
class NetworkInfo {
  static final NetworkInfo _instance = NetworkInfo._internal();
  factory NetworkInfo() => _instance;
  NetworkInfo._internal();

  final Connectivity _connectivity = Connectivity();
  
  /// Current network status
  NetworkStatus _currentStatus = NetworkStatus.unknown;
  
  /// Stream controller for network status changes
  final StreamController<NetworkStatus> _statusController = 
      StreamController<NetworkStatus>.broadcast();
  
  /// Stream subscription for connectivity changes
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  
  /// Last time internet connectivity was verified
  DateTime? _lastInternetCheck;
  
  /// Cache duration for internet connectivity check
  static const Duration _internetCheckCache = Duration(seconds: 30);

  /// Initialize network monitoring
  Future<void> initialize() async {
    // Get initial connectivity status
    await _updateNetworkStatus();
    
    // Listen for connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _onConnectivityChanged,
      onError: (error) {
        debugPrint('Network connectivity error: $error');
      },
    );
  }

  /// Dispose network monitoring
  void dispose() {
    _connectivitySubscription?.cancel();
    _statusController.close();
  }

  /// Get current network status
  NetworkStatus get currentStatus => _currentStatus;

  /// Check if device is connected to any network
  bool get isConnected => _currentStatus != NetworkStatus.offline;

  /// Check if device is connected to WiFi
  bool get isWifi => _currentStatus == NetworkStatus.wifi;

  /// Check if device is connected to mobile network
  bool get isMobile => _currentStatus == NetworkStatus.mobile;

  /// Check if device is connected to ethernet
  bool get isEthernet => _currentStatus == NetworkStatus.ethernet;

  /// Check if device is offline
  bool get isOffline => _currentStatus == NetworkStatus.offline;

  /// Stream of network status changes
  Stream<NetworkStatus> get onStatusChanged => _statusController.stream;

  /// Check internet connectivity with actual network call
  Future<bool> hasInternetConnection({bool useCache = true}) async {
    // Return cached result if available and recent
    if (useCache && 
        _lastInternetCheck != null && 
        DateTime.now().difference(_lastInternetCheck!) < _internetCheckCache) {
      return isConnected;
    }

    try {
      // Try to connect to reliable hosts
      final results = await Future.wait([
        _checkHost('8.8.8.8', 53), // Google DNS
        _checkHost('1.1.1.1', 53), // Cloudflare DNS
      ]).timeout(const Duration(seconds: 10));
      
      final hasInternet = results.any((result) => result);
      _lastInternetCheck = DateTime.now();
      
      return hasInternet;
    } catch (e) {
      debugPrint('Internet connectivity check failed: $e');
      _lastInternetCheck = DateTime.now();
      return false;
    }
  }

  /// Check connection to specific host
  Future<bool> _checkHost(String host, int port) async {
    try {
      final socket = await Socket.connect(host, port, timeout: const Duration(seconds: 5));
      socket.destroy();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Force refresh network status
  Future<void> refreshStatus() async {
    await _updateNetworkStatus();
  }

  /// Update network status based on connectivity
  Future<void> _updateNetworkStatus() async {
    try {
      final connectivityResults = await _connectivity.checkConnectivity();
      final newStatus = _mapConnectivityToStatus(connectivityResults);
      
      if (newStatus != _currentStatus) {
        final oldStatus = _currentStatus;
        _currentStatus = newStatus;
        
        // Notify listeners
        _statusController.add(_currentStatus);
        
        // Log status change
        debugPrint('Network status changed: $oldStatus -> $_currentStatus');
      }
    } catch (e) {
      debugPrint('Failed to update network status: $e');
      _currentStatus = NetworkStatus.unknown;
      _statusController.add(_currentStatus);
    }
  }

  /// Handle connectivity changes
  void _onConnectivityChanged(List<ConnectivityResult> results) {
    final newStatus = _mapConnectivityToStatus(results);
    
    if (newStatus != _currentStatus) {
      final oldStatus = _currentStatus;
      _currentStatus = newStatus;
      
      // Clear internet check cache on connectivity change
      _lastInternetCheck = null;
      
      // Notify listeners
      _statusController.add(_currentStatus);
      
      // Log status change
      debugPrint('Network connectivity changed: $oldStatus -> $_currentStatus');
    }
  }

  /// Map ConnectivityResult to NetworkStatus
  NetworkStatus _mapConnectivityToStatus(List<ConnectivityResult> results) {
    if (results.isEmpty) {
      return NetworkStatus.offline;
    }
    
    // Check for ethernet first (highest priority)
    if (results.contains(ConnectivityResult.ethernet)) {
      return NetworkStatus.ethernet;
    }
    
    // Check for WiFi
    if (results.contains(ConnectivityResult.wifi)) {
      return NetworkStatus.wifi;
    }
    
    // Check for mobile data
    if (results.contains(ConnectivityResult.mobile)) {
      return NetworkStatus.mobile;
    }
    
    // Check for other connections
    if (results.contains(ConnectivityResult.other)) {
      return NetworkStatus.wifi; // Treat other connections as WiFi
    }
    
    // No connection
    if (results.contains(ConnectivityResult.none)) {
      return NetworkStatus.offline;
    }
    
    return NetworkStatus.unknown;
  }

  /// Get network type description
  String get networkTypeDescription {
    switch (_currentStatus) {
      case NetworkStatus.mobile:
        return 'Mobile Data';
      case NetworkStatus.wifi:
        return 'WiFi';
      case NetworkStatus.ethernet:
        return 'Ethernet';
      case NetworkStatus.offline:
        return 'Offline';
      case NetworkStatus.unknown:
        return 'Unknown';
    }
  }

  /// Check if network is suitable for heavy operations
  bool get isSuitableForHeavyOperations {
    return _currentStatus == NetworkStatus.wifi || 
           _currentStatus == NetworkStatus.ethernet;
  }

  /// Check if should warn about mobile data usage
  bool get shouldWarnAboutDataUsage {
    return _currentStatus == NetworkStatus.mobile;
  }

  /// Get network signal quality (mock implementation)
  NetworkSignalQuality get signalQuality {
    // In a real implementation, you might use platform-specific APIs
    // to get actual signal strength
    switch (_currentStatus) {
      case NetworkStatus.ethernet:
        return NetworkSignalQuality.excellent;
      case NetworkStatus.wifi:
        return NetworkSignalQuality.good; // Could be dynamic based on signal
      case NetworkStatus.mobile:
        return NetworkSignalQuality.fair; // Could be dynamic based on signal
      case NetworkStatus.offline:
      case NetworkStatus.unknown:
        return NetworkSignalQuality.none;
    }
  }
}

/// Network signal quality levels
enum NetworkSignalQuality {
  /// No signal
  none,
  
  /// Poor signal quality
  poor,
  
  /// Fair signal quality
  fair,
  
  /// Good signal quality
  good,
  
  /// Excellent signal quality
  excellent,
}

/// Network monitoring mixin for widgets
mixin NetworkAware {
  /// Stream subscription for network status
  StreamSubscription<NetworkStatus>? _networkSubscription;
  
  /// Current network status
  NetworkStatus _networkStatus = NetworkStatus.unknown;
  
  /// Initialize network monitoring
  void initializeNetworkMonitoring() {
    _networkSubscription = NetworkInfo().onStatusChanged.listen(
      _onNetworkStatusChanged,
    );
    _networkStatus = NetworkInfo().currentStatus;
  }
  
  /// Dispose network monitoring
  void disposeNetworkMonitoring() {
    _networkSubscription?.cancel();
  }
  
  /// Handle network status changes
  void _onNetworkStatusChanged(NetworkStatus status) {
    final oldStatus = _networkStatus;
    _networkStatus = status;
    
    // Call the overridable method
    onNetworkStatusChanged(oldStatus, status);
  }
  
  /// Override this method to handle network status changes
  void onNetworkStatusChanged(NetworkStatus oldStatus, NetworkStatus newStatus) {
    // Default implementation does nothing
    debugPrint('Network status changed: $oldStatus -> $newStatus');
  }
  
  /// Get current network status
  NetworkStatus get networkStatus => _networkStatus;
  
  /// Check if connected to network
  bool get isNetworkConnected => _networkStatus != NetworkStatus.offline;
  
  /// Check if suitable for heavy operations
  bool get isNetworkSuitableForHeavyOps => 
      _networkStatus == NetworkStatus.wifi || 
      _networkStatus == NetworkStatus.ethernet;
}

/// Extension for easy network status checks
extension NetworkStatusExtension on NetworkStatus {
  /// Check if status represents a connection
  bool get isConnected => this != NetworkStatus.offline;
  
  /// Check if status is WiFi
  bool get isWifi => this == NetworkStatus.wifi;
  
  /// Check if status is mobile
  bool get isMobile => this == NetworkStatus.mobile;
  
  /// Check if status is ethernet
  bool get isEthernet => this == NetworkStatus.ethernet;
  
  /// Check if status is offline
  bool get isOffline => this == NetworkStatus.offline;
  
  /// Get user-friendly description
  String get description {
    switch (this) {
      case NetworkStatus.mobile:
        return 'Mobile Data';
      case NetworkStatus.wifi:
        return 'WiFi';
      case NetworkStatus.ethernet:
        return 'Ethernet';
      case NetworkStatus.offline:
        return 'No Connection';
      case NetworkStatus.unknown:
        return 'Unknown';
    }
  }
  
  /// Get icon data for status
  String get icon {
    switch (this) {
      case NetworkStatus.mobile:
        return '📱';
      case NetworkStatus.wifi:
        return '📶';
      case NetworkStatus.ethernet:
        return '🔌';
      case NetworkStatus.offline:
        return '❌';
      case NetworkStatus.unknown:
        return '❓';
    }
  }
}
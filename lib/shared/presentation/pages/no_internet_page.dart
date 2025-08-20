import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../app/constants/app_colors.dart';
import '../../../app/providers/app_providers.dart';

class NoInternetPage extends ConsumerStatefulWidget {
  const NoInternetPage({super.key});

  @override
  ConsumerState<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends ConsumerState<NoInternetPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  bool _isRetrying = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startAnimations();
  }

  void _initAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
    ));
  }

  void _startAnimations() {
    _animationController.forward();
  }

  Future<void> _retryConnection() async {
    setState(() {
      _isRetrying = true;
    });

    try {
      // Check connectivity
      final networkInfo = ref.read(networkInfoProvider);
      final isConnected = await networkInfo.isConnected;

      if (isConnected) {
        // Connection restored, close this page or navigate back
        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        // Still no connection, show feedback
        if (mounted) {
          _showRetryFeedback();
        }
      }
    } catch (e) {
      if (mounted) {
        _showRetryFeedback();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isRetrying = false;
        });
      }
    }
  }

  void _showRetryFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Still no internet connection. Please check your network.'),
        backgroundColor: AppColors.warning,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: AppColors.onWarning,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Listen to connectivity changes
    ref.listen<AsyncValue<List<ConnectivityResult>>>(
      connectivityStreamProvider,
      (previous, next) {
        next.whenData((results) {
          if (!results.contains(ConnectivityResult.none)) {
            // Connection restored
            if (mounted) {
              Navigator.of(context).pop();
            }
          }
        });
      },
    );
    
    return Scaffold(
      backgroundColor: isDark 
          ? AppColors.backgroundDark 
          : AppColors.background,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // No Internet Illustration
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: isDark 
                              ? AppColors.errorContainerDark 
                              : AppColors.errorContainer,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: AppColors.error.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wifi_off_rounded,
                              size: 80,
                              color: isDark 
                                  ? AppColors.onErrorContainerDark 
                                  : AppColors.onErrorContainer,
                            ),
                            const SizedBox(height: 16),
                            Icon(
                              Icons.signal_cellular_connected_no_internet_0_bar,
                              size: 32,
                              color: isDark 
                                  ? AppColors.onErrorContainerDark 
                                  : AppColors.onErrorContainer,
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 48),
                      
                      // Error Message
                      Text(
                        'No Internet Connection',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark 
                              ? AppColors.textPrimaryDark 
                              : AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      Text(
                        'Please check your internet connection and try again. Make sure Wi-Fi or mobile data is turned on.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isDark 
                              ? AppColors.textSecondaryDark 
                              : AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 48),
                      
                      // Connection Status Card
                      Card(
                        color: isDark 
                            ? AppColors.surfaceDark 
                            : AppColors.surface,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: isDark 
                                        ? AppColors.infoDark 
                                        : AppColors.info,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Connection Status',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: isDark 
                                          ? AppColors.textPrimaryDark 
                                          : AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 16),
                              
                              Consumer(
                                builder: (context, ref, child) {
                                  final connectivityState = ref.watch(connectivityStreamProvider);
                                  
                                  return connectivityState.when(
                                    data: (results) {
                                      String status;
                                      Color statusColor;
                                      IconData statusIcon;
                                      
                                      if (results.contains(ConnectivityResult.wifi)) {
                                        status = 'Wi-Fi (No Internet)';
                                        statusColor = AppColors.warning;
                                        statusIcon = Icons.wifi_outlined;
                                      } else if (results.contains(ConnectivityResult.mobile)) {
                                        status = 'Mobile Data (No Internet)';
                                        statusColor = AppColors.warning;
                                        statusIcon = Icons.signal_cellular_alt_outlined;
                                      } else if (results.contains(ConnectivityResult.ethernet)) {
                                        status = 'Ethernet (No Internet)';
                                        statusColor = AppColors.warning;
                                        statusIcon = Icons.settings_ethernet_outlined;
                                      } else {
                                        status = 'No Connection';
                                        statusColor = AppColors.error;
                                        statusIcon = Icons.signal_cellular_off_outlined;
                                      }
                                      
                                      return Row(
                                        children: [
                                          Icon(
                                            statusIcon,
                                            color: statusColor,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            status,
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: statusColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    loading: () => const Row(
                                      children: [
                                        SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        ),
                                        SizedBox(width: 8),
                                        Text('Checking connection...'),
                                      ],
                                    ),
                                    error: (error, stackTrace) => Row(
                                      children: [
                                        Icon(
                                          Icons.error_outline,
                                          color: AppColors.error,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Connection check failed',
                                          style: TextStyle(
                                            color: AppColors.error,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Action Buttons
                      Column(
                        children: [
                          // Retry Button
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton.icon(
                              onPressed: _isRetrying ? null : _retryConnection,
                              icon: _isRetrying 
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.onPrimary,
                                        ),
                                      ),
                                    )
                                  : const Icon(Icons.refresh_outlined),
                              label: Text(_isRetrying ? 'Checking...' : 'Try Again'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Settings Button
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Open device network settings
                                // Note: This would require platform-specific implementation
                                _showSettingsDialog();
                              },
                              icon: const Icon(Icons.settings_outlined),
                              label: const Text('Network Settings'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: isDark 
                                    ? AppColors.primaryDark 
                                    : AppColors.primary,
                                side: BorderSide(
                                  color: isDark 
                                      ? AppColors.primaryDark 
                                      : AppColors.primary,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Help Text
                      Text(
                        'The app requires internet connection to function properly.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark 
                              ? AppColors.textDisabledDark 
                              : AppColors.textDisabled,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Network Settings'),
        content: const Text(
          'Please check your network settings and ensure:\n\n'
          '• Wi-Fi or Mobile data is enabled\n'
          '• You have a stable internet connection\n'
          '• Network permissions are granted to this app',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
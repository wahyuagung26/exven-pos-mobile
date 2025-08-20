import 'dart:async';

import 'package:flutter/material.dart';

/// Types of notifications
enum NotificationType {
  success,
  error,
  warning,
  info,
}

/// Notification configuration
class NotificationConfig {
  final String title;
  final String message;
  final NotificationType type;
  final Duration duration;
  final bool showCloseButton;
  final VoidCallback? onTap;
  final VoidCallback? onClose;
  final IconData? customIcon;
  final Color? customColor;

  const NotificationConfig({
    required this.title,
    required this.message,
    this.type = NotificationType.info,
    this.duration = const Duration(seconds: 4),
    this.showCloseButton = true,
    this.onTap,
    this.onClose,
    this.customIcon,
    this.customColor,
  });
}

/// Notification service for showing user-friendly messages
/// Provides consistent UI feedback across the application
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  /// Global navigation key for overlay access
  static GlobalKey<NavigatorState>? _navigatorKey;
  
  /// Currently active notifications
  final List<OverlayEntry> _activeNotifications = [];
  
  /// Maximum number of notifications to show simultaneously
  static const int maxNotifications = 3;

  /// Initialize notification service with navigator key
  static void initialize(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
  }

  /// Show notification with basic parameters
  void showNotification({
    required String title,
    required String message,
    NotificationType type = NotificationType.info,
    Duration? duration,
    VoidCallback? onTap,
  }) {
    final config = NotificationConfig(
      title: title,
      message: message,
      type: type,
      duration: duration ?? const Duration(seconds: 4),
      onTap: onTap,
    );
    
    _showNotificationWithConfig(config);
  }

  /// Show success notification
  void showSuccess({
    required String title,
    required String message,
    Duration? duration,
    VoidCallback? onTap,
  }) {
    showNotification(
      title: title,
      message: message,
      type: NotificationType.success,
      duration: duration,
      onTap: onTap,
    );
  }

  /// Show error notification
  void showError({
    required String title,
    required String message,
    Duration? duration,
    VoidCallback? onTap,
  }) {
    showNotification(
      title: title,
      message: message,
      type: NotificationType.error,
      duration: duration ?? const Duration(seconds: 6), // Longer for errors
      onTap: onTap,
    );
  }

  /// Show warning notification
  void showWarning({
    required String title,
    required String message,
    Duration? duration,
    VoidCallback? onTap,
  }) {
    showNotification(
      title: title,
      message: message,
      type: NotificationType.warning,
      duration: duration,
      onTap: onTap,
    );
  }

  /// Show info notification
  void showInfo({
    required String title,
    required String message,
    Duration? duration,
    VoidCallback? onTap,
  }) {
    showNotification(
      title: title,
      message: message,
      type: NotificationType.info,
      duration: duration,
      onTap: onTap,
    );
  }

  /// Show notification with custom configuration
  void showCustom(NotificationConfig config) {
    _showNotificationWithConfig(config);
  }

  /// Internal method to show notification with overlay
  void _showNotificationWithConfig(NotificationConfig config) {
    if (_navigatorKey?.currentState?.overlay == null) {
      debugPrint('NotificationService: Overlay not available');
      return;
    }

    // Remove oldest notification if at max capacity
    if (_activeNotifications.length >= maxNotifications) {
      _removeOldestNotification();
    }

    final overlayEntry = OverlayEntry(
      builder: (context) => _NotificationWidget(
        config: config,
        onRemove: () => _removeNotification(overlayEntry),
        position: _activeNotifications.length,
      ),
    );

    _activeNotifications.add(overlayEntry);
    _navigatorKey!.currentState!.overlay!.insert(overlayEntry);

    // Auto-remove after duration
    Timer(config.duration, () {
      _removeNotification(overlayEntry);
    });
  }

  /// Remove specific notification
  void _removeNotification(OverlayEntry entry) {
    if (_activeNotifications.contains(entry)) {
      entry.remove();
      _activeNotifications.remove(entry);
      _updateNotificationPositions();
    }
  }

  /// Remove oldest notification
  void _removeOldestNotification() {
    if (_activeNotifications.isNotEmpty) {
      final oldest = _activeNotifications.first;
      _removeNotification(oldest);
    }
  }

  /// Update positions of all notifications
  void _updateNotificationPositions() {
    for (int i = 0; i < _activeNotifications.length; i++) {
      _activeNotifications[i].markNeedsBuild();
    }
  }

  /// Clear all notifications
  void clearAll() {
    final notifications = List<OverlayEntry>.from(_activeNotifications);
    for (final entry in notifications) {
      _removeNotification(entry);
    }
  }

  /// Get notification theme data based on type
  static _NotificationTheme _getThemeForType(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return _NotificationTheme(
          icon: Icons.check_circle,
          color: Colors.green,
          backgroundColor: Colors.green.withOpacity(0.1),
        );
      case NotificationType.error:
        return _NotificationTheme(
          icon: Icons.error,
          color: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.1),
        );
      case NotificationType.warning:
        return _NotificationTheme(
          icon: Icons.warning,
          color: Colors.orange,
          backgroundColor: Colors.orange.withOpacity(0.1),
        );
      case NotificationType.info:
        return _NotificationTheme(
          icon: Icons.info,
          color: Colors.blue,
          backgroundColor: Colors.blue.withOpacity(0.1),
        );
    }
  }
}

/// Notification theme data
class _NotificationTheme {
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  const _NotificationTheme({
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });
}

/// Notification widget
class _NotificationWidget extends StatefulWidget {
  final NotificationConfig config;
  final VoidCallback onRemove;
  final int position;

  const _NotificationWidget({
    required this.config,
    required this.onRemove,
    required this.position,
  });

  @override
  State<_NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<_NotificationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _dismiss() {
    _animationController.reverse().then((_) {
      widget.onRemove();
      widget.config.onClose?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = NotificationService._getThemeForType(widget.config.type);
    const notificationHeight = 80.0;
    const notificationMargin = 12.0;
    
    return Positioned(
      top: MediaQuery.of(context).padding.top + 
           16 + 
           (widget.position * (notificationHeight + notificationMargin)),
      right: 16,
      left: 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: notificationHeight,
              decoration: BoxDecoration(
                color: widget.config.customColor ?? theme.backgroundColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: (widget.config.customColor ?? theme.color)
                      .withOpacity(0.3),
                ),
              ),
              child: InkWell(
                onTap: widget.config.onTap,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        widget.config.customIcon ?? theme.icon,
                        color: widget.config.customColor ?? theme.color,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.config.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: widget.config.customColor ?? theme.color,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.config.message,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (widget.config.showCloseButton) ...[
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _dismiss,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Extension for easy access to notification service
extension NotificationExtension on BuildContext {
  NotificationService get notifications => NotificationService();
}
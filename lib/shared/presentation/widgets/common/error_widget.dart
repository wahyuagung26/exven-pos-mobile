import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  final String? details;
  final VoidCallback? onRetry;
  final String retryLabel;
  final IconData icon;
  final bool showDetails;
  final EdgeInsetsGeometry padding;

  const CustomErrorWidget({
    super.key,
    required this.message,
    this.details,
    this.onRetry,
    this.retryLabel = 'Try Again',
    this.icon = Icons.error_outline,
    this.showDetails = false,
    this.padding = const EdgeInsets.all(24.0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          if (showDetails && details != null) ...[
            const SizedBox(height: 12),
            ExpansionTile(
              title: Text(
                'Error Details',
                style: theme.textTheme.bodyMedium,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    details!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 24),
          if (onRetry != null)
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(retryLabel),
            ),
        ],
      ),
    );
  }
}

class InlineErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String retryLabel;
  final double height;

  const InlineErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.retryLabel = 'Retry',
    this.height = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      height: height,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 24,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: onRetry,
              child: Text(retryLabel),
            ),
          ],
        ],
      ),
    );
  }
}

class NetworkErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final String retryLabel;

  const NetworkErrorWidget({
    super.key,
    this.onRetry,
    this.retryLabel = 'Try Again',
  });

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      message: 'Check your internet connection and try again.',
      icon: Icons.wifi_off_outlined,
      onRetry: onRetry,
      retryLabel: retryLabel,
    );
  }
}

class ServerErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final String retryLabel;

  const ServerErrorWidget({
    super.key,
    this.onRetry,
    this.retryLabel = 'Try Again',
  });

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      message: 'Server is currently unavailable. Please try again later.',
      icon: Icons.cloud_off_outlined,
      onRetry: onRetry,
      retryLabel: retryLabel,
    );
  }
}

class TimeoutErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final String retryLabel;

  const TimeoutErrorWidget({
    super.key,
    this.onRetry,
    this.retryLabel = 'Try Again',
  });

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      message: 'Request timed out. Please check your connection and try again.',
      icon: Icons.schedule_outlined,
      onRetry: onRetry,
      retryLabel: retryLabel,
    );
  }
}

class UnauthorizedErrorWidget extends StatelessWidget {
  final VoidCallback? onLogin;
  final String loginLabel;

  const UnauthorizedErrorWidget({
    super.key,
    this.onLogin,
    this.loginLabel = 'Login',
  });

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      message: 'Your session has expired. Please log in again.',
      icon: Icons.lock_outline,
      onRetry: onLogin,
      retryLabel: loginLabel,
    );
  }
}
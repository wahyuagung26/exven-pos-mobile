import 'package:flutter/material.dart';

class UnauthorizedWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final Widget? customAction;
  final bool showBackground;

  const UnauthorizedWidget({
    super.key,
    this.message = 'You are not authorized to view this content',
    this.icon = Icons.lock_outline,
    this.actionLabel,
    this.onActionPressed,
    this.customAction,
    this.showBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final content = Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: theme.colorScheme.primary.withOpacity(0.7),
          ),
          const SizedBox(height: 24),
          Text(
            'Access Restricted',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 32),
          _buildAction(context),
        ],
      ),
    );

    if (showBackground) {
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: content,
          ),
        ),
      );
    }

    return Center(
      child: SingleChildScrollView(
        child: content,
      ),
    );
  }

  Widget _buildAction(BuildContext context) {
    if (customAction != null) {
      return customAction!;
    }

    if (actionLabel != null && onActionPressed != null) {
      return FilledButton(
        onPressed: onActionPressed,
        child: Text(actionLabel!),
      );
    }

    return const SizedBox.shrink();
  }
}

class MinimalUnauthorizedWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color? iconColor;
  final TextStyle? textStyle;

  const MinimalUnauthorizedWidget({
    super.key,
    this.message = 'Access denied',
    this.icon = Icons.block_outlined,
    this.iconColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: iconColor ?? theme.colorScheme.outline,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: textStyle ?? 
              theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
          ),
        ],
      ),
    );
  }
}
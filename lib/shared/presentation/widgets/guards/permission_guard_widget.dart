import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/permission_providers.dart';
import 'unauthorized_widget.dart';

class PermissionGuardWidget extends ConsumerWidget {
  final Widget child;
  final String permission;
  final Widget? fallback;
  final bool showUnauthorized;
  final String? customMessage;

  const PermissionGuardWidget({
    super.key,
    required this.child,
    required this.permission,
    this.fallback,
    this.showUnauthorized = true,
    this.customMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPermission = ref.watch(hasPermissionProvider(permission));

    return hasPermission.when(
      data: (allowed) {
        if (!allowed) {
          if (!showUnauthorized && fallback != null) {
            return fallback!;
          }
          
          return UnauthorizedWidget(
            message: customMessage ?? 
              'You don\'t have permission to access this feature',
            icon: Icons.block_outlined,
          );
        }

        return child;
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, _) => UnauthorizedWidget(
        message: 'Error checking permissions: ${error.toString()}',
        icon: Icons.error_outline,
      ),
    );
  }
}

class MultiPermissionGuardWidget extends ConsumerWidget {
  final Widget child;
  final List<String> permissions;
  final bool requireAll;
  final Widget? fallback;
  final bool showUnauthorized;
  final String? customMessage;

  const MultiPermissionGuardWidget({
    super.key,
    required this.child,
    required this.permissions,
    this.requireAll = false,
    this.fallback,
    this.showUnauthorized = true,
    this.customMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionChecks = permissions.map(
      (permission) => ref.watch(hasPermissionProvider(permission))
    ).toList();

    final isLoading = permissionChecks.any(
      (check) => check.isLoading
    );

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final hasError = permissionChecks.any(
      (check) => check.hasError
    );

    if (hasError) {
      return UnauthorizedWidget(
        message: 'Error checking permissions',
        icon: Icons.error_outline,
      );
    }

    final results = permissionChecks
        .map((check) => check.value ?? false)
        .toList();

    final hasAccess = requireAll
        ? results.every((allowed) => allowed)
        : results.any((allowed) => allowed);

    if (!hasAccess) {
      if (!showUnauthorized && fallback != null) {
        return fallback!;
      }
      
      return UnauthorizedWidget(
        message: customMessage ?? 
          'You don\'t have the required permissions to access this feature',
        icon: Icons.block_outlined,
      );
    }

    return child;
  }
}

class PermissionVisibility extends ConsumerWidget {
  final Widget child;
  final String permission;
  final Widget? replacement;

  const PermissionVisibility({
    super.key,
    required this.child,
    required this.permission,
    this.replacement,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPermission = ref.watch(hasPermissionProvider(permission));

    return hasPermission.maybeWhen(
      data: (allowed) {
        if (allowed) {
          return child;
        }
        return replacement ?? const SizedBox.shrink();
      },
      orElse: () => replacement ?? const SizedBox.shrink(),
    );
  }
}

class ConditionalPermissionWidget extends ConsumerWidget {
  final Widget Function(bool hasPermission) builder;
  final String permission;

  const ConditionalPermissionWidget({
    super.key,
    required this.builder,
    required this.permission,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPermission = ref.watch(hasPermissionProvider(permission));

    return hasPermission.maybeWhen(
      data: (allowed) => builder(allowed),
      orElse: () => builder(false),
    );
  }
}
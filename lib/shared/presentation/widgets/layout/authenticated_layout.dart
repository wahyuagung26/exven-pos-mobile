import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../guards/auth_guard_widget.dart';
import '../guards/tenant_guard_widget.dart';
import '../../providers/auth_guard_providers.dart';

class AuthenticatedLayout extends ConsumerWidget {
  final Widget child;
  final bool requireTenant;
  final bool requireActiveSubscription;
  final bool checkTenantAccess;
  final String? customUnauthorizedMessage;

  const AuthenticatedLayout({
    super.key,
    required this.child,
    this.requireTenant = true,
    this.requireActiveSubscription = true,
    this.checkTenantAccess = true,
    this.customUnauthorizedMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AuthGuardWidget(
      requireActiveSubscription: requireActiveSubscription && !requireTenant,
      checkTenantAccess: checkTenantAccess && !requireTenant,
      child: requireTenant
          ? TenantGuardWidget(
              requireActiveSubscription: requireActiveSubscription,
              customMessage: customUnauthorizedMessage,
              child: child,
            )
          : child,
    );
  }
}

class ConditionalAuthenticatedLayout extends ConsumerWidget {
  final Widget authenticatedChild;
  final Widget unauthenticatedChild;
  final bool requireTenant;
  final bool requireActiveSubscription;

  const ConditionalAuthenticatedLayout({
    super.key,
    required this.authenticatedChild,
    required this.unauthenticatedChild,
    this.requireTenant = false,
    this.requireActiveSubscription = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(isAuthenticatedProvider);

    return isAuthenticated.when(
      data: (authenticated) {
        if (!authenticated) {
          return unauthenticatedChild;
        }

        if (requireTenant || requireActiveSubscription) {
          return TenantGuardWidget(
            requireActiveSubscription: requireActiveSubscription,
            fallback: unauthenticatedChild,
            child: authenticatedChild,
          );
        }

        return authenticatedChild;
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => unauthenticatedChild,
    );
  }
}

class MultiGuardLayout extends ConsumerWidget {
  final Widget child;
  final List<String> requiredPermissions;
  final bool requireAllPermissions;
  final bool requireTenant;
  final bool requireActiveSubscription;
  final Widget? fallback;

  const MultiGuardLayout({
    super.key,
    required this.child,
    this.requiredPermissions = const [],
    this.requireAllPermissions = false,
    this.requireTenant = true,
    this.requireActiveSubscription = true,
    this.fallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget guardedChild = child;

    if (requiredPermissions.isNotEmpty) {
      if (requiredPermissions.length == 1) {
        guardedChild = ref.watch(guardPermissionProvider(
          requiredPermissions.first,
        )).when(
          data: (hasPermission) => hasPermission ? guardedChild : _buildFallback(),
          loading: () => _buildLoading(),
          error: (_, __) => _buildFallback(),
        );
      } else {
        guardedChild = ref.watch(guardMultiplePermissionsProvider(
          requiredPermissions,
          requireAll: requireAllPermissions,
        )).when(
          data: (hasPermissions) => hasPermissions ? guardedChild : _buildFallback(),
          loading: () => _buildLoading(),
          error: (_, __) => _buildFallback(),
        );
      }
    }

    return AuthenticatedLayout(
      requireTenant: requireTenant,
      requireActiveSubscription: requireActiveSubscription,
      child: guardedChild,
    );
  }

  Widget _buildFallback() {
    return fallback ?? const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Access Denied',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'You don\'t have permission to access this page.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class AdminLayout extends StatelessWidget {
  final Widget child;
  final Widget? fallback;

  const AdminLayout({
    super.key,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return MultiGuardLayout(
      requiredPermissions: const ['admin.access'],
      requireTenant: true,
      requireActiveSubscription: true,
      fallback: fallback,
      child: child,
    );
  }
}

class ManagerLayout extends StatelessWidget {
  final Widget child;
  final Widget? fallback;

  const ManagerLayout({
    super.key,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return MultiGuardLayout(
      requiredPermissions: const ['manager.access'],
      requireTenant: true,
      requireActiveSubscription: true,
      fallback: fallback,
      child: child,
    );
  }
}
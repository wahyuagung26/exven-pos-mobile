import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/providers/auth_providers.dart';
import '../common/loading_widget.dart';

class AuthGuardWidget extends ConsumerWidget {
  final Widget child;
  final Widget? fallback;
  final String? redirectTo;
  final bool requireActiveSubscription;
  final bool checkTenantAccess;

  const AuthGuardWidget({
    super.key,
    required this.child,
    this.fallback,
    this.redirectTo = '/login',
    this.requireActiveSubscription = false,
    this.checkTenantAccess = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          if (fallback != null) {
            return fallback!;
          }
          
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted && redirectTo != null) {
              context.go(redirectTo!);
            }
          });
          
          return const LoadingWidget(
            message: 'Checking authentication...',
          );
        }

        if (requireActiveSubscription && !_hasActiveSubscription(user)) {
          if (fallback != null) {
            return fallback!;
          }
          
          return _buildSubscriptionRequired(context);
        }

        if (checkTenantAccess && !_hasTenantAccess(user)) {
          if (fallback != null) {
            return fallback!;
          }
          
          return _buildNoTenantAccess(context);
        }

        return child;
      },
      loading: () => const LoadingWidget(
        message: 'Authenticating...',
      ),
      error: (error, _) => _buildErrorWidget(context, error),
    );
  }

  bool _hasActiveSubscription(dynamic user) {
    return user.subscription?.isActive == true;
  }

  bool _hasTenantAccess(dynamic user) {
    return user.tenantId != null && user.tenantId.isNotEmpty;
  }

  Widget _buildSubscriptionRequired(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Subscription Required',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'Please activate your subscription to access this feature.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () => context.go('/subscription'),
                child: const Text('View Plans'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoTenantAccess(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.business_outlined,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'No Business Access',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'Please select or create a business to continue.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () => context.go('/tenant/select'),
                child: const Text('Select Business'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, Object error) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 80,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 24),
              Text(
                'Authentication Error',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () => context.go('/login'),
                child: const Text('Go to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
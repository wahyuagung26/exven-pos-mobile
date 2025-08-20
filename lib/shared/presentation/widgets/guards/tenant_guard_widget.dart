import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/providers/tenant_providers.dart';
import '../../../domain/providers/auth_providers.dart';
import '../common/loading_widget.dart';
import 'unauthorized_widget.dart';

class TenantGuardWidget extends ConsumerWidget {
  final Widget child;
  final Widget? fallback;
  final String? redirectTo;
  final bool requireActiveSubscription;
  final String? customMessage;

  const TenantGuardWidget({
    super.key,
    required this.child,
    this.fallback,
    this.redirectTo = '/tenant/select',
    this.requireActiveSubscription = true,
    this.customMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final currentTenant = ref.watch(currentTenantProvider);

    return currentUser.when(
      data: (user) {
        if (user == null) {
          return fallback ?? const UnauthorizedWidget();
        }

        if (user.tenantId == null || user.tenantId!.isEmpty) {
          return _buildNoTenant(context);
        }

        return currentTenant.when(
          data: (tenant) {
            if (tenant == null) {
              return _buildTenantNotFound(context);
            }

            if (!tenant.isActive) {
              return _buildTenantInactive(context, tenant.name);
            }

            if (requireActiveSubscription && !_hasActiveSubscription(tenant)) {
              return _buildSubscriptionRequired(context, tenant.name);
            }

            return child;
          },
          loading: () => const LoadingWidget(
            message: 'Loading business information...',
          ),
          error: (error, _) => _buildErrorWidget(context, error),
        );
      },
      loading: () => const LoadingWidget(
        message: 'Checking access...',
      ),
      error: (error, _) => _buildErrorWidget(context, error),
    );
  }

  bool _hasActiveSubscription(dynamic tenant) {
    return tenant.subscription?.isActive == true;
  }

  Widget _buildNoTenant(BuildContext context) {
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
                'No Business Selected',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                customMessage ?? 
                'Please select or create a business to continue.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () => context.go('/tenant/select'),
                    child: const Text('Select Business'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () => context.go('/tenant/create'),
                    child: const Text('Create New'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTenantNotFound(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off_outlined,
                size: 80,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 24),
              Text(
                'Business Not Found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'The selected business could not be found or you don\'t have access to it.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () => context.go('/tenant/select'),
                child: const Text('Select Another Business'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTenantInactive(BuildContext context, String tenantName) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.pause_circle_outline,
                size: 80,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 24),
              Text(
                'Business Suspended',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'The business "$tenantName" has been temporarily suspended.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () => context.go('/tenant/select'),
                    child: const Text('Select Another'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () => context.go('/support'),
                    child: const Text('Contact Support'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionRequired(BuildContext context, String tenantName) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.credit_card_off_outlined,
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
                'Please activate a subscription for "$tenantName" to access this feature.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () => context.go('/subscription'),
                    child: const Text('View Plans'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () => context.go('/tenant/select'),
                    child: const Text('Switch Business'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, Object error) {
    return UnauthorizedWidget(
      message: 'Error accessing business: ${error.toString()}',
      icon: Icons.error_outline,
      actionLabel: 'Try Again',
      onActionPressed: () => context.go('/tenant/select'),
    );
  }
}
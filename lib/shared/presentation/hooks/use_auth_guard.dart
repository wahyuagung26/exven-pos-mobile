import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/providers/auth_providers.dart';
import '../../domain/providers/tenant_providers.dart';

class AuthGuardState {
  final bool isAuthenticated;
  final bool hasTenantAccess;
  final bool hasActiveSubscription;
  final bool isLoading;
  final String? error;

  const AuthGuardState({
    required this.isAuthenticated,
    required this.hasTenantAccess,
    required this.hasActiveSubscription,
    required this.isLoading,
    this.error,
  });

  bool get hasFullAccess => isAuthenticated && hasTenantAccess && hasActiveSubscription;
  bool get canAccessApp => isAuthenticated;
  bool get canAccessTenantFeatures => isAuthenticated && hasTenantAccess;
  bool get canAccessPaidFeatures => isAuthenticated && hasTenantAccess && hasActiveSubscription;

  AuthGuardState copyWith({
    bool? isAuthenticated,
    bool? hasTenantAccess,
    bool? hasActiveSubscription,
    bool? isLoading,
    String? error,
  }) {
    return AuthGuardState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      hasTenantAccess: hasTenantAccess ?? this.hasTenantAccess,
      hasActiveSubscription: hasActiveSubscription ?? this.hasActiveSubscription,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final authGuardProvider = Provider<AuthGuardState>((ref) {
  final authState = ref.watch(authStateProvider);
  final currentTenant = ref.watch(currentTenantProvider);

  return authState.when(
    data: (user) {
      if (user == null) {
        return const AuthGuardState(
          isAuthenticated: false,
          hasTenantAccess: false,
          hasActiveSubscription: false,
          isLoading: false,
        );
      }

      return currentTenant.when(
        data: (tenant) {
          final hasTenantAccess = user.tenantId != null && 
                                  user.tenantId!.isNotEmpty &&
                                  tenant != null &&
                                  tenant.isActive;

          final hasActiveSubscription = tenant?.subscription?.isActive ?? false;

          return AuthGuardState(
            isAuthenticated: true,
            hasTenantAccess: hasTenantAccess,
            hasActiveSubscription: hasActiveSubscription,
            isLoading: false,
          );
        },
        loading: () => const AuthGuardState(
          isAuthenticated: true,
          hasTenantAccess: false,
          hasActiveSubscription: false,
          isLoading: true,
        ),
        error: (error, _) => AuthGuardState(
          isAuthenticated: true,
          hasTenantAccess: false,
          hasActiveSubscription: false,
          isLoading: false,
          error: error.toString(),
        ),
      );
    },
    loading: () => const AuthGuardState(
      isAuthenticated: false,
      hasTenantAccess: false,
      hasActiveSubscription: false,
      isLoading: true,
    ),
    error: (error, _) => AuthGuardState(
      isAuthenticated: false,
      hasTenantAccess: false,
      hasActiveSubscription: false,
      isLoading: false,
      error: error.toString(),
    ),
  );
});

final canAccessAppProvider = Provider<bool>((ref) {
  final authGuard = ref.watch(authGuardProvider);
  return authGuard.canAccessApp;
});

final canAccessTenantFeaturesProvider = Provider<bool>((ref) {
  final authGuard = ref.watch(authGuardProvider);
  return authGuard.canAccessTenantFeatures;
});

final canAccessPaidFeaturesProvider = Provider<bool>((ref) {
  final authGuard = ref.watch(authGuardProvider);
  return authGuard.canAccessPaidFeatures;
});

final hasFullAccessProvider = Provider<bool>((ref) {
  final authGuard = ref.watch(authGuardProvider);
  return authGuard.hasFullAccess;
});

class UseAuthGuard {
  final AuthGuardState state;
  final WidgetRef _ref;

  UseAuthGuard._(this.state, this._ref);

  static UseAuthGuard of(WidgetRef ref) {
    final state = ref.watch(authGuardProvider);
    return UseAuthGuard._(state, ref);
  }

  bool get isAuthenticated => state.isAuthenticated;
  bool get hasTenantAccess => state.hasTenantAccess;
  bool get hasActiveSubscription => state.hasActiveSubscription;
  bool get isLoading => state.isLoading;
  bool get hasError => state.error != null;
  String? get error => state.error;

  bool get canAccessApp => state.canAccessApp;
  bool get canAccessTenantFeatures => state.canAccessTenantFeatures;
  bool get canAccessPaidFeatures => state.canAccessPaidFeatures;
  bool get hasFullAccess => state.hasFullAccess;

  Future<void> refreshAuth() async {
    _ref.invalidate(authStateProvider);
  }

  Future<void> refreshTenant() async {
    _ref.invalidate(currentTenantProvider);
  }

  Future<void> logout() async {
    await _ref.read(authStateProvider.notifier).logout();
  }

  bool requiresAuthentication() => !isAuthenticated;
  bool requiresTenant() => isAuthenticated && !hasTenantAccess;
  bool requiresSubscription() => isAuthenticated && hasTenantAccess && !hasActiveSubscription;
  
  String? getRedirectReason() {
    if (!isAuthenticated) return 'authentication_required';
    if (!hasTenantAccess) return 'tenant_required';
    if (!hasActiveSubscription) return 'subscription_required';
    return null;
  }
}
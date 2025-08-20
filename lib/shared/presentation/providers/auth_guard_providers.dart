import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/providers/auth_providers.dart';
import '../../domain/providers/tenant_providers.dart';

final isAuthenticatedProvider = Provider<AsyncValue<bool>>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return authState.when(
    data: (user) => AsyncValue.data(user != null),
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

final hasTenantAccessProvider = Provider<AsyncValue<bool>>((ref) {
  final currentUser = ref.watch(currentUserProvider);
  final currentTenant = ref.watch(currentTenantProvider);
  
  return currentUser.when(
    data: (user) {
      if (user == null) {
        return const AsyncValue.data(false);
      }
      
      return currentTenant.when(
        data: (tenant) {
          final hasAccess = user.tenantId != null && 
                           user.tenantId!.isNotEmpty &&
                           tenant != null &&
                           tenant.isActive;
          return AsyncValue.data(hasAccess);
        },
        loading: () => const AsyncValue.loading(),
        error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
      );
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

final hasActiveSubscriptionProvider = Provider<AsyncValue<bool>>((ref) {
  final currentTenant = ref.watch(currentTenantProvider);
  
  return currentTenant.when(
    data: (tenant) {
      final hasActiveSubscription = tenant?.subscription?.isActive ?? false;
      return AsyncValue.data(hasActiveSubscription);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

final canAccessAppProvider = Provider<AsyncValue<bool>>((ref) {
  return ref.watch(isAuthenticatedProvider);
});

final canAccessTenantFeaturesProvider = Provider<AsyncValue<bool>>((ref) {
  final isAuthenticated = ref.watch(isAuthenticatedProvider);
  final hasTenantAccess = ref.watch(hasTenantAccessProvider);
  
  return isAuthenticated.when(
    data: (authenticated) {
      if (!authenticated) {
        return const AsyncValue.data(false);
      }
      
      return hasTenantAccess;
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

final canAccessPaidFeaturesProvider = Provider<AsyncValue<bool>>((ref) {
  final canAccessTenant = ref.watch(canAccessTenantFeaturesProvider);
  final hasActiveSubscription = ref.watch(hasActiveSubscriptionProvider);
  
  return canAccessTenant.when(
    data: (canAccess) {
      if (!canAccess) {
        return const AsyncValue.data(false);
      }
      
      return hasActiveSubscription;
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

final hasFullAccessProvider = Provider<AsyncValue<bool>>((ref) {
  return ref.watch(canAccessPaidFeaturesProvider);
});

final guardPermissionProvider = Provider.family<AsyncValue<bool>, String>((ref, permission) {
  final permissionsAsync = ref.watch(userPermissionsProvider);
  
  return permissionsAsync.when(
    data: (permissions) {
      final hasPermission = permissions.contains(permission);
      return AsyncValue.data(hasPermission);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

final guardMultiplePermissionsProvider = Provider.family<AsyncValue<bool>, GuardPermissionsQuery>((ref, query) {
  final permissionsAsync = ref.watch(userPermissionsProvider);
  
  return permissionsAsync.when(
    data: (permissions) {
      final hasPermissions = query.requireAll
          ? query.permissions.every((permission) => permissions.contains(permission))
          : query.permissions.any((permission) => permissions.contains(permission));
      return AsyncValue.data(hasPermissions);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

final guardRoleProvider = Provider.family<AsyncValue<bool>, String>((ref, requiredRole) {
  final currentUser = ref.watch(currentUserProvider);
  
  return currentUser.when(
    data: (user) {
      if (user == null) {
        return const AsyncValue.data(false);
      }
      
      final userRole = user.role;
      final hasRole = _checkRoleAccess(userRole, requiredRole);
      return AsyncValue.data(hasRole);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

final guardMultipleRolesProvider = Provider.family<AsyncValue<bool>, GuardRolesQuery>((ref, query) {
  final currentUser = ref.watch(currentUserProvider);
  
  return currentUser.when(
    data: (user) {
      if (user == null) {
        return const AsyncValue.data(false);
      }
      
      final userRole = user.role;
      final hasRole = query.requireAll
          ? query.roles.every((role) => _checkRoleAccess(userRole, role))
          : query.roles.any((role) => _checkRoleAccess(userRole, role));
      return AsyncValue.data(hasRole);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

bool _checkRoleAccess(String? userRole, String requiredRole) {
  if (userRole == null) return false;
  
  final userPriority = _getRolePriority(userRole);
  final requiredPriority = _getRolePriority(requiredRole);
  
  return userPriority >= requiredPriority;
}

int _getRolePriority(String role) {
  switch (role.toLowerCase()) {
    case 'owner':
      return 3;
    case 'manager':
      return 2;
    case 'cashier':
      return 1;
    default:
      return 0;
  }
}

class GuardPermissionsQuery {
  final List<String> permissions;
  final bool requireAll;

  const GuardPermissionsQuery({
    required this.permissions,
    this.requireAll = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is GuardPermissionsQuery &&
        other.permissions.length == permissions.length &&
        other.permissions.every(permissions.contains) &&
        other.requireAll == requireAll;
  }

  @override
  int get hashCode {
    return Object.hash(permissions, requireAll);
  }
}

class GuardRolesQuery {
  final List<String> roles;
  final bool requireAll;

  const GuardRolesQuery({
    required this.roles,
    this.requireAll = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is GuardRolesQuery &&
        other.roles.length == roles.length &&
        other.roles.every(roles.contains) &&
        other.requireAll == requireAll;
  }

  @override
  int get hashCode {
    return Object.hash(roles, requireAll);
  }
}
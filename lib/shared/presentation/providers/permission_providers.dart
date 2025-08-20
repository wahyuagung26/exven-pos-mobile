import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/providers/auth_providers.dart';

final permissionsProvider = FutureProvider<Set<String>>((ref) async {
  final currentUser = ref.watch(currentUserProvider);
  
  return currentUser.when(
    data: (user) async {
      if (user == null) return <String>{};
      
      final permissions = await _fetchUserPermissions(user);
      return permissions.toSet();
    },
    loading: () => throw const AsyncLoading(),
    error: (error, stackTrace) => throw AsyncError(error, stackTrace),
  );
});

final hasPermissionProvider = Provider.family<AsyncValue<bool>, String>((ref, permission) {
  final permissionsAsync = ref.watch(permissionsProvider);
  
  return permissionsAsync.when(
    data: (permissions) => AsyncValue.data(permissions.contains(permission)),
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

final hasAnyPermissionProvider = Provider.family<AsyncValue<bool>, List<String>>((ref, permissionList) {
  final permissionsAsync = ref.watch(permissionsProvider);
  
  return permissionsAsync.when(
    data: (permissions) {
      final hasAny = permissionList.any((permission) => permissions.contains(permission));
      return AsyncValue.data(hasAny);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

final hasAllPermissionsProvider = Provider.family<AsyncValue<bool>, List<String>>((ref, permissionList) {
  final permissionsAsync = ref.watch(permissionsProvider);
  
  return permissionsAsync.when(
    data: (permissions) {
      final hasAll = permissionList.every((permission) => permissions.contains(permission));
      return AsyncValue.data(hasAll);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

final userPermissionsProvider = Provider<AsyncValue<Set<String>>>((ref) {
  final permissionsAsync = ref.watch(permissionsProvider);
  
  return permissionsAsync.when(
    data: (permissions) => AsyncValue.data(permissions),
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

final roleBasedPermissionsProvider = Provider<AsyncValue<Set<String>>>((ref) {
  final currentUser = ref.watch(currentUserProvider);
  
  return currentUser.when(
    data: (user) {
      if (user == null) {
        return const AsyncValue.data(<String>{});
      }
      
      final permissions = _getRolePermissions(user.role);
      return AsyncValue.data(permissions.toSet());
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

final effectivePermissionsProvider = Provider<AsyncValue<Set<String>>>((ref) {
  final userPermissions = ref.watch(userPermissionsProvider);
  final rolePermissions = ref.watch(roleBasedPermissionsProvider);
  
  return userPermissions.when(
    data: (userPerms) => rolePermissions.when(
      data: (rolePerms) {
        final combined = <String>{...userPerms, ...rolePerms};
        return AsyncValue.data(combined);
      },
      loading: () => AsyncValue.data(userPerms),
      error: (error, stackTrace) => AsyncValue.data(userPerms),
    ),
    loading: () => rolePermissions.when(
      data: (rolePerms) => AsyncValue.data(rolePerms),
      loading: () => const AsyncValue.loading(),
      error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
    ),
    error: (error, stackTrace) => rolePermissions.when(
      data: (rolePerms) => AsyncValue.data(rolePerms),
      loading: () => AsyncValue.error(error, stackTrace),
      error: (_, __) => AsyncValue.error(error, stackTrace),
    ),
  );
});

final permissionCacheProvider = StateProvider<Map<String, bool>>((ref) => {});

final cachedPermissionProvider = Provider.family<bool, String>((ref, permission) {
  final cache = ref.watch(permissionCacheProvider);
  final hasPermissionAsync = ref.watch(hasPermissionProvider(permission));
  
  return hasPermissionAsync.when(
    data: (hasPermission) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(permissionCacheProvider.notifier).update((state) {
          return {...state, permission: hasPermission};
        });
      });
      return hasPermission;
    },
    loading: () => cache[permission] ?? false,
    error: (_, __) => cache[permission] ?? false,
  );
});

Future<List<String>> _fetchUserPermissions(dynamic user) async {
  final permissions = <String>[];
  
  if (user.role == 'owner') {
    permissions.addAll(_getOwnerPermissions());
  } else if (user.role == 'manager') {
    permissions.addAll(_getManagerPermissions());
  } else if (user.role == 'cashier') {
    permissions.addAll(_getCashierPermissions());
  }
  
  if (user.customPermissions != null) {
    permissions.addAll(List<String>.from(user.customPermissions));
  }
  
  return permissions;
}

List<String> _getRolePermissions(String? role) {
  switch (role?.toLowerCase()) {
    case 'owner':
      return _getOwnerPermissions();
    case 'manager':
      return _getManagerPermissions();
    case 'cashier':
      return _getCashierPermissions();
    default:
      return [];
  }
}

List<String> _getOwnerPermissions() {
  return [
    'admin.access',
    'admin.dashboard',
    'admin.users.view',
    'admin.users.create',
    'admin.users.edit',
    'admin.users.delete',
    'admin.tenants.view',
    'admin.tenants.create',
    'admin.tenants.edit',
    'admin.tenants.delete',
    'admin.settings',
    'manager.access',
    'pos.access',
    'products.view',
    'products.create',
    'products.edit',
    'products.delete',
    'customers.view',
    'customers.create',
    'customers.edit',
    'customers.delete',
    'transactions.view',
    'transactions.create',
    'transactions.edit',
    'transactions.delete',
    'reports.view',
    'reports.export',
    'inventory.view',
    'inventory.manage',
    'settings.view',
    'settings.edit',
  ];
}

List<String> _getManagerPermissions() {
  return [
    'manager.access',
    'pos.access',
    'products.view',
    'products.create',
    'products.edit',
    'products.delete',
    'customers.view',
    'customers.create',
    'customers.edit',
    'customers.delete',
    'transactions.view',
    'transactions.create',
    'transactions.edit',
    'reports.view',
    'reports.export',
    'inventory.view',
    'inventory.manage',
    'settings.view',
  ];
}

List<String> _getCashierPermissions() {
  return [
    'pos.access',
    'products.view',
    'customers.view',
    'customers.create',
    'customers.edit',
    'transactions.view',
    'transactions.create',
    'inventory.view',
  ];
}

final hasAdminAccessProvider = Provider<AsyncValue<bool>>((ref) {
  return ref.watch(hasPermissionProvider('admin.access'));
});

final hasManagerAccessProvider = Provider<AsyncValue<bool>>((ref) {
  return ref.watch(hasPermissionProvider('manager.access'));
});

final hasPosAccessProvider = Provider<AsyncValue<bool>>((ref) {
  return ref.watch(hasPermissionProvider('pos.access'));
});

final canManageProductsProvider = Provider<AsyncValue<bool>>((ref) {
  return ref.watch(hasAnyPermissionProvider(['products.create', 'products.edit', 'products.delete']));
});

final canManageCustomersProvider = Provider<AsyncValue<bool>>((ref) {
  return ref.watch(hasAnyPermissionProvider(['customers.create', 'customers.edit', 'customers.delete']));
});

final canViewReportsProvider = Provider<AsyncValue<bool>>((ref) {
  return ref.watch(hasPermissionProvider('reports.view'));
});

final canExportReportsProvider = Provider<AsyncValue<bool>>((ref) {
  return ref.watch(hasPermissionProvider('reports.export'));
});

final canManageInventoryProvider = Provider<AsyncValue<bool>>((ref) {
  return ref.watch(hasPermissionProvider('inventory.manage'));
});

final canManageSettingsProvider = Provider<AsyncValue<bool>>((ref) {
  return ref.watch(hasAnyPermissionProvider(['settings.edit', 'admin.settings']));
});
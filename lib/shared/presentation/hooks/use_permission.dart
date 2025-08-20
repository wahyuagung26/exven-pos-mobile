import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/permission_providers.dart';

class PermissionState {
  final Map<String, bool> permissions;
  final bool isLoading;
  final String? error;

  const PermissionState({
    required this.permissions,
    required this.isLoading,
    this.error,
  });

  bool hasPermission(String permission) => permissions[permission] ?? false;

  bool hasAnyPermission(List<String> permissionList) {
    return permissionList.any((permission) => hasPermission(permission));
  }

  bool hasAllPermissions(List<String> permissionList) {
    return permissionList.every((permission) => hasPermission(permission));
  }

  PermissionState copyWith({
    Map<String, bool>? permissions,
    bool? isLoading,
    String? error,
  }) {
    return PermissionState(
      permissions: permissions ?? this.permissions,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class UsePermission {
  final String permission;
  final WidgetRef _ref;

  UsePermission._(this.permission, this._ref);

  static UsePermission of(WidgetRef ref, String permission) {
    return UsePermission._(permission, ref);
  }

  AsyncValue<bool> get state => _ref.watch(hasPermissionProvider(permission));

  bool get hasPermission => state.value ?? false;
  bool get isLoading => state.isLoading;
  bool get hasError => state.hasError;
  Object? get error => state.error;

  void refresh() {
    _ref.invalidate(hasPermissionProvider(permission));
  }
}

class UseMultiplePermissions {
  final List<String> permissions;
  final bool requireAll;
  final WidgetRef _ref;

  UseMultiplePermissions._(this.permissions, this.requireAll, this._ref);

  static UseMultiplePermissions of(
    WidgetRef ref, 
    List<String> permissions, {
    bool requireAll = false,
  }) {
    return UseMultiplePermissions._(permissions, requireAll, ref);
  }

  Map<String, AsyncValue<bool>> get individualStates {
    return Map.fromEntries(
      permissions.map((permission) => 
        MapEntry(permission, _ref.watch(hasPermissionProvider(permission)))
      )
    );
  }

  bool get hasPermissions {
    final states = individualStates.values.map((state) => state.value ?? false);
    return requireAll 
      ? states.every((hasPermission) => hasPermission)
      : states.any((hasPermission) => hasPermission);
  }

  bool get isLoading {
    return individualStates.values.any((state) => state.isLoading);
  }

  bool get hasError {
    return individualStates.values.any((state) => state.hasError);
  }

  List<Object> get errors {
    return individualStates.values
        .where((state) => state.hasError)
        .map((state) => state.error!)
        .toList();
  }

  Map<String, bool> get permissionMap {
    return Map.fromEntries(
      permissions.map((permission) => 
        MapEntry(permission, _ref.watch(hasPermissionProvider(permission)).value ?? false)
      )
    );
  }

  void refresh() {
    for (final permission in permissions) {
      _ref.invalidate(hasPermissionProvider(permission));
    }
  }

  void refreshPermission(String permission) {
    if (permissions.contains(permission)) {
      _ref.invalidate(hasPermissionProvider(permission));
    }
  }
}

class UsePermissionCache {
  final WidgetRef _ref;

  UsePermissionCache._(this._ref);

  static UsePermissionCache of(WidgetRef ref) {
    return UsePermissionCache._(ref);
  }

  bool hasPermission(String permission) {
    return _ref.watch(hasPermissionProvider(permission)).value ?? false;
  }

  bool hasAnyPermission(List<String> permissions) {
    return permissions.any((permission) => hasPermission(permission));
  }

  bool hasAllPermissions(List<String> permissions) {
    return permissions.every((permission) => hasPermission(permission));
  }

  void preloadPermissions(List<String> permissions) {
    for (final permission in permissions) {
      _ref.read(hasPermissionProvider(permission));
    }
  }

  void refreshPermissions(List<String>? permissions) {
    if (permissions != null) {
      for (final permission in permissions) {
        _ref.invalidate(hasPermissionProvider(permission));
      }
    } else {
      _ref.invalidate(permissionsProvider);
    }
  }

  void clearCache() {
    _ref.invalidate(permissionsProvider);
  }
}

final usePermissionProvider = Provider.family<UsePermission, String>((ref, permission) {
  return UsePermission.of(ref, permission);
});

final useMultiplePermissionsProvider = Provider.family<UseMultiplePermissions, PermissionQuery>((ref, query) {
  return UseMultiplePermissions.of(ref, query.permissions, requireAll: query.requireAll);
});

class PermissionQuery {
  final List<String> permissions;
  final bool requireAll;

  const PermissionQuery({
    required this.permissions,
    this.requireAll = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is PermissionQuery &&
        other.permissions.length == permissions.length &&
        other.permissions.every(permissions.contains) &&
        other.requireAll == requireAll;
  }

  @override
  int get hashCode {
    return Object.hash(permissions, requireAll);
  }
}
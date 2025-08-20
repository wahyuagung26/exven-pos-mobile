import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/providers/auth_providers.dart';
import '../../domain/providers/tenant_providers.dart';
import '../widgets/guards/role_guard_widget.dart';

class CurrentUserState {
  final dynamic user;
  final dynamic tenant;
  final bool isLoading;
  final String? error;

  const CurrentUserState({
    this.user,
    this.tenant,
    required this.isLoading,
    this.error,
  });

  bool get isAuthenticated => user != null;
  bool get hasTenant => tenant != null && user?.tenantId != null;
  bool get hasActiveSubscription => tenant?.subscription?.isActive ?? false;

  String? get userId => user?.id;
  String? get userName => user?.name;
  String? get userEmail => user?.email;
  String? get userRole => user?.role;
  UserRole? get userRoleEnum => UserRole.fromString(user?.role);

  String? get tenantId => user?.tenantId ?? tenant?.id;
  String? get tenantName => tenant?.name;
  String? get subscriptionPlan => tenant?.subscription?.plan;
  bool get tenantIsActive => tenant?.isActive ?? false;

  CurrentUserState copyWith({
    dynamic user,
    dynamic tenant,
    bool? isLoading,
    String? error,
  }) {
    return CurrentUserState(
      user: user ?? this.user,
      tenant: tenant ?? this.tenant,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final currentUserStateProvider = Provider<CurrentUserState>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  final tenantAsync = ref.watch(currentTenantProvider);

  return userAsync.when(
    data: (user) => tenantAsync.when(
      data: (tenant) => CurrentUserState(
        user: user,
        tenant: tenant,
        isLoading: false,
      ),
      loading: () => CurrentUserState(
        user: user,
        tenant: null,
        isLoading: true,
      ),
      error: (error, _) => CurrentUserState(
        user: user,
        tenant: null,
        isLoading: false,
        error: error.toString(),
      ),
    ),
    loading: () => const CurrentUserState(
      isLoading: true,
    ),
    error: (error, _) => CurrentUserState(
      isLoading: false,
      error: error.toString(),
    ),
  );
});

class UseCurrentUser {
  final CurrentUserState state;
  final WidgetRef _ref;

  UseCurrentUser._(this.state, this._ref);

  static UseCurrentUser of(WidgetRef ref) {
    final state = ref.watch(currentUserStateProvider);
    return UseCurrentUser._(state, ref);
  }

  dynamic get user => state.user;
  dynamic get tenant => state.tenant;
  bool get isLoading => state.isLoading;
  bool get hasError => state.error != null;
  String? get error => state.error;

  bool get isAuthenticated => state.isAuthenticated;
  bool get hasTenant => state.hasTenant;
  bool get hasActiveSubscription => state.hasActiveSubscription;

  String? get userId => state.userId;
  String? get userName => state.userName;
  String? get userEmail => state.userEmail;
  String? get userRole => state.userRole;
  UserRole? get userRoleEnum => state.userRoleEnum;

  String? get tenantId => state.tenantId;
  String? get tenantName => state.tenantName;
  String? get subscriptionPlan => state.subscriptionPlan;
  bool get tenantIsActive => state.tenantIsActive;

  bool hasRole(UserRole role) {
    final currentRole = userRoleEnum;
    return currentRole != null && currentRole.priority >= role.priority;
  }

  bool hasAnyRole(List<UserRole> roles) {
    final currentRole = userRoleEnum;
    if (currentRole == null) return false;
    
    return roles.any((role) => currentRole.priority >= role.priority);
  }

  bool isOwner() => hasRole(UserRole.owner);
  bool isManager() => hasRole(UserRole.manager);
  bool isCashier() => hasRole(UserRole.cashier);

  bool canManage() => hasAnyRole([UserRole.owner, UserRole.manager]);
  bool canOnlyOperate() => userRoleEnum == UserRole.cashier;

  String getUserDisplayName() {
    if (userName?.isNotEmpty == true) return userName!;
    if (userEmail?.isNotEmpty == true) return userEmail!;
    return 'User';
  }

  String getTenantDisplayName() {
    if (tenantName?.isNotEmpty == true) return tenantName!;
    return 'Business';
  }

  String getInitials() {
    final name = getUserDisplayName();
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : 'U';
  }

  Future<void> refreshUser() async {
    _ref.invalidate(currentUserProvider);
  }

  Future<void> refreshTenant() async {
    _ref.invalidate(currentTenantProvider);
  }

  Future<void> refreshAll() async {
    _ref.invalidate(currentUserProvider);
    _ref.invalidate(currentTenantProvider);
  }

  Future<void> logout() async {
    await _ref.read(authStateProvider.notifier).logout();
  }
}

final useCurrentUserProvider = Provider<UseCurrentUser>((ref) {
  final state = ref.watch(currentUserStateProvider);
  return UseCurrentUser._(state, ref);
});

class UseUserProfile {
  final WidgetRef _ref;

  UseUserProfile._(this._ref);

  static UseUserProfile of(WidgetRef ref) {
    return UseUserProfile._(ref);
  }

  CurrentUserState get state => _ref.watch(currentUserStateProvider);
  UseCurrentUser get user => UseCurrentUser.of(_ref);

  Map<String, dynamic> getProfileData() {
    return {
      'id': user.userId,
      'name': user.userName,
      'email': user.userEmail,
      'role': user.userRole,
      'tenantId': user.tenantId,
      'tenantName': user.tenantName,
      'subscriptionPlan': user.subscriptionPlan,
      'isActive': user.tenantIsActive,
      'hasActiveSubscription': user.hasActiveSubscription,
    };
  }

  bool canAccessFeature(String feature) {
    switch (feature) {
      case 'admin':
        return user.isOwner();
      case 'management':
        return user.canManage();
      case 'pos':
        return user.isAuthenticated;
      case 'reports':
        return user.canManage();
      case 'settings':
        return user.canManage();
      default:
        return user.isAuthenticated;
    }
  }

  List<String> getAvailableFeatures() {
    final features = <String>[];
    
    if (user.isAuthenticated) {
      features.add('pos');
      
      if (user.canManage()) {
        features.addAll(['management', 'reports', 'settings']);
      }
      
      if (user.isOwner()) {
        features.add('admin');
      }
    }
    
    return features;
  }
}
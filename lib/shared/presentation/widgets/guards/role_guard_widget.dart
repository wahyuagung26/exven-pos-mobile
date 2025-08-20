import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/providers/auth_providers.dart';
import 'unauthorized_widget.dart';

enum UserRole {
  owner('Owner'),
  manager('Manager'),
  cashier('Cashier');

  final String displayName;
  const UserRole(this.displayName);

  static UserRole? fromString(String? role) {
    if (role == null) return null;
    
    switch (role.toLowerCase()) {
      case 'owner':
        return UserRole.owner;
      case 'manager':
        return UserRole.manager;
      case 'cashier':
        return UserRole.cashier;
      default:
        return null;
    }
  }

  int get priority {
    switch (this) {
      case UserRole.owner:
        return 3;
      case UserRole.manager:
        return 2;
      case UserRole.cashier:
        return 1;
    }
  }
}

class RoleGuardWidget extends ConsumerWidget {
  final Widget child;
  final List<UserRole> allowedRoles;
  final Widget? fallback;
  final bool showUnauthorized;
  final String? customMessage;

  const RoleGuardWidget({
    super.key,
    required this.child,
    required this.allowedRoles,
    this.fallback,
    this.showUnauthorized = true,
    this.customMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return currentUser.when(
      data: (user) {
        if (user == null) {
          return fallback ?? const UnauthorizedWidget();
        }

        final userRole = UserRole.fromString(user.role);
        
        if (userRole == null) {
          return fallback ?? 
            UnauthorizedWidget(
              message: customMessage ?? 'Invalid user role',
            );
        }

        final hasAccess = _checkRoleAccess(userRole, allowedRoles);

        if (!hasAccess) {
          if (!showUnauthorized && fallback != null) {
            return fallback!;
          }
          
          return UnauthorizedWidget(
            message: customMessage ?? 
              'You need ${_getRolesText(allowedRoles)} role to access this feature',
            icon: Icons.lock_person_outlined,
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

  bool _checkRoleAccess(UserRole userRole, List<UserRole> allowedRoles) {
    if (allowedRoles.isEmpty) return true;
    
    if (allowedRoles.contains(userRole)) return true;
    
    for (final allowedRole in allowedRoles) {
      if (userRole.priority >= allowedRole.priority) {
        return true;
      }
    }
    
    return false;
  }

  String _getRolesText(List<UserRole> roles) {
    if (roles.isEmpty) return '';
    if (roles.length == 1) return roles.first.displayName;
    
    final rolesText = roles.map((r) => r.displayName).toList();
    final last = rolesText.removeLast();
    return '${rolesText.join(', ')} or $last';
  }
}

class RoleVisibility extends ConsumerWidget {
  final Widget child;
  final List<UserRole> visibleFor;
  final Widget? replacement;

  const RoleVisibility({
    super.key,
    required this.child,
    required this.visibleFor,
    this.replacement,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return currentUser.maybeWhen(
      data: (user) {
        if (user == null) {
          return replacement ?? const SizedBox.shrink();
        }

        final userRole = UserRole.fromString(user.role);
        
        if (userRole == null) {
          return replacement ?? const SizedBox.shrink();
        }

        final isVisible = _checkVisibility(userRole, visibleFor);
        
        if (isVisible) {
          return child;
        }
        
        return replacement ?? const SizedBox.shrink();
      },
      orElse: () => replacement ?? const SizedBox.shrink(),
    );
  }

  bool _checkVisibility(UserRole userRole, List<UserRole> visibleFor) {
    if (visibleFor.isEmpty) return true;
    
    for (final allowedRole in visibleFor) {
      if (userRole.priority >= allowedRole.priority) {
        return true;
      }
    }
    
    return false;
  }
}
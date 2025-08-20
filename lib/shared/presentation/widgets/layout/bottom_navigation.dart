import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/permission_providers.dart';

class NavigationItem {
  final String route;
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final String? permission;
  final List<String>? permissions;
  final bool requireAllPermissions;

  const NavigationItem({
    required this.route,
    required this.icon,
    this.activeIcon,
    required this.label,
    this.permission,
    this.permissions,
    this.requireAllPermissions = false,
  });
}

class AppBottomNavigation extends ConsumerWidget {
  final List<NavigationItem> items;
  final int currentIndex;
  final Function(int)? onTap;

  const AppBottomNavigation({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibleItems = <NavigationItem>[];
    final visibleIndexMap = <int, int>{};
    
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      
      if (_hasPermission(ref, item)) {
        visibleIndexMap[i] = visibleItems.length;
        visibleItems.add(item);
      }
    }

    if (visibleItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return NavigationBar(
      selectedIndex: visibleIndexMap[currentIndex] ?? 0,
      onDestinationSelected: (index) {
        final originalIndex = visibleIndexMap.entries
            .firstWhere((entry) => entry.value == index)
            .key;
        
        if (onTap != null) {
          onTap!(originalIndex);
        } else {
          context.go(visibleItems[index].route);
        }
      },
      destinations: visibleItems.map((item) {
        return NavigationDestination(
          icon: Icon(item.icon),
          selectedIcon: item.activeIcon != null ? Icon(item.activeIcon!) : null,
          label: item.label,
        );
      }).toList(),
    );
  }

  bool _hasPermission(WidgetRef ref, NavigationItem item) {
    if (item.permission != null) {
      final hasPermission = ref.watch(hasPermissionProvider(item.permission!));
      return hasPermission.value ?? false;
    }
    
    if (item.permissions != null && item.permissions!.isNotEmpty) {
      final permissions = item.permissions!
          .map((p) => ref.watch(hasPermissionProvider(p)))
          .toList();
      
      final results = permissions.map((p) => p.value ?? false).toList();
      
      return item.requireAllPermissions
          ? results.every((hasPermission) => hasPermission)
          : results.any((hasPermission) => hasPermission);
    }
    
    return true;
  }
}

class PosBottomNavigation extends ConsumerWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const PosBottomNavigation({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const items = [
      NavigationItem(
        route: '/pos',
        icon: Icons.point_of_sale_outlined,
        activeIcon: Icons.point_of_sale,
        label: 'POS',
        permission: 'pos.access',
      ),
      NavigationItem(
        route: '/products',
        icon: Icons.inventory_2_outlined,
        activeIcon: Icons.inventory_2,
        label: 'Products',
        permission: 'products.view',
      ),
      NavigationItem(
        route: '/customers',
        icon: Icons.people_outline,
        activeIcon: Icons.people,
        label: 'Customers',
        permission: 'customers.view',
      ),
      NavigationItem(
        route: '/transactions',
        icon: Icons.receipt_outlined,
        activeIcon: Icons.receipt,
        label: 'Sales',
        permission: 'transactions.view',
      ),
      NavigationItem(
        route: '/reports',
        icon: Icons.analytics_outlined,
        activeIcon: Icons.analytics,
        label: 'Reports',
        permission: 'reports.view',
      ),
    ];

    return AppBottomNavigation(
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}

class AdminBottomNavigation extends ConsumerWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const AdminBottomNavigation({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const items = [
      NavigationItem(
        route: '/admin/dashboard',
        icon: Icons.dashboard_outlined,
        activeIcon: Icons.dashboard,
        label: 'Dashboard',
        permission: 'admin.dashboard',
      ),
      NavigationItem(
        route: '/admin/users',
        icon: Icons.group_outlined,
        activeIcon: Icons.group,
        label: 'Users',
        permission: 'admin.users.view',
      ),
      NavigationItem(
        route: '/admin/tenants',
        icon: Icons.business_outlined,
        activeIcon: Icons.business,
        label: 'Tenants',
        permission: 'admin.tenants.view',
      ),
      NavigationItem(
        route: '/admin/settings',
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings,
        label: 'Settings',
        permission: 'admin.settings',
      ),
    ];

    return AppBottomNavigation(
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}

class SimpleBottomNavigation extends StatelessWidget {
  final List<SimpleNavigationItem> items;
  final int currentIndex;
  final Function(int)? onTap;

  const SimpleBottomNavigation({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: items.map((item) {
        return NavigationDestination(
          icon: Icon(item.icon),
          selectedIcon: item.activeIcon != null ? Icon(item.activeIcon!) : null,
          label: item.label,
        );
      }).toList(),
    );
  }
}

class SimpleNavigationItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;

  const SimpleNavigationItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
}
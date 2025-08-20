import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/providers/auth_providers.dart';
import '../../../domain/providers/tenant_providers.dart';
import '../guards/role_guard_widget.dart';
import '../../providers/permission_providers.dart';

class AppDrawer extends ConsumerWidget {
  final bool showProfile;
  final bool showTenantInfo;
  final List<DrawerItem>? customItems;

  const AppDrawer({
    super.key,
    this.showProfile = true,
    this.showTenantInfo = true,
    this.customItems,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final currentTenant = ref.watch(currentTenantProvider);
    
    return Drawer(
      child: Column(
        children: [
          if (showProfile) _buildUserHeader(context, currentUser, currentTenant),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                if (showTenantInfo) _buildTenantInfo(context, currentTenant),
                ..._buildDefaultItems(context),
                if (customItems != null) ...customItems!.map(_buildDrawerItem),
                const Divider(),
                _buildDrawerItem(DrawerItem(
                  title: 'Logout',
                  icon: Icons.logout,
                  onTap: () => _logout(context, ref),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader(
    BuildContext context,
    AsyncValue currentUser,
    AsyncValue currentTenant,
  ) {
    return currentUser.when(
      data: (user) => UserAccountsDrawerHeader(
        accountName: Text(user?.name ?? 'User'),
        accountEmail: Text(user?.email ?? ''),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            (user?.name ?? 'U').substring(0, 1).toUpperCase(),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        otherAccountsPictures: currentTenant.when(
          data: (tenant) => tenant != null ? [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text(
                tenant.name.substring(0, 1).toUpperCase(),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ] : null,
          loading: () => null,
          error: (_, __) => null,
        ),
      ),
      loading: () => const DrawerHeader(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const DrawerHeader(
        child: Center(child: Text('Error loading user')),
      ),
    );
  }

  Widget _buildTenantInfo(BuildContext context, AsyncValue currentTenant) {
    return currentTenant.when(
      data: (tenant) {
        if (tenant == null) return const SizedBox.shrink();
        
        return Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Business',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  tenant.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (tenant.subscription != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        tenant.subscription!.isActive
                            ? Icons.check_circle
                            : Icons.warning,
                        size: 16,
                        color: tenant.subscription!.isActive
                            ? Colors.green
                            : Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        tenant.subscription!.plan,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => context.go('/tenant/select'),
                  child: const Text('Switch Business'),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  List<Widget> _buildDefaultItems(BuildContext context) {
    final defaultItems = [
      DrawerItem(
        title: 'Dashboard',
        icon: Icons.dashboard_outlined,
        route: '/dashboard',
      ),
      DrawerItem(
        title: 'Point of Sale',
        icon: Icons.point_of_sale_outlined,
        route: '/pos',
        permission: 'pos.access',
      ),
      DrawerItem(
        title: 'Products',
        icon: Icons.inventory_2_outlined,
        route: '/products',
        permission: 'products.view',
      ),
      DrawerItem(
        title: 'Customers',
        icon: Icons.people_outline,
        route: '/customers',
        permission: 'customers.view',
      ),
      DrawerItem(
        title: 'Transactions',
        icon: Icons.receipt_outlined,
        route: '/transactions',
        permission: 'transactions.view',
      ),
      DrawerItem(
        title: 'Reports',
        icon: Icons.analytics_outlined,
        route: '/reports',
        permission: 'reports.view',
      ),
      DrawerItem(
        title: 'Settings',
        icon: Icons.settings_outlined,
        route: '/settings',
      ),
    ];

    return defaultItems.map(_buildDrawerItem).toList();
  }

  Widget _buildDrawerItem(DrawerItem item) {
    if (item.permission != null) {
      return PermissionVisibility(
        permission: item.permission!,
        child: _buildListTile(item),
      );
    }

    if (item.visibleForRoles != null && item.visibleForRoles!.isNotEmpty) {
      return RoleVisibility(
        visibleFor: item.visibleForRoles!,
        child: _buildListTile(item),
      );
    }

    return _buildListTile(item);
  }

  Widget _buildListTile(DrawerItem item) {
    return ListTile(
      leading: Icon(item.icon),
      title: Text(item.title),
      trailing: item.trailing,
      onTap: item.onTap ?? (item.route != null
          ? () => _navigateAndClose(item.route!)
          : null),
    );
  }

  void _navigateAndClose(String route) {
    // Close drawer first, then navigate
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GoRouter.of(GlobalKey().currentContext!).go(route);
    });
  }

  void _logout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(authStateProvider.notifier).logout();
              context.go('/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class DrawerItem {
  final String title;
  final IconData icon;
  final String? route;
  final VoidCallback? onTap;
  final Widget? trailing;
  final String? permission;
  final List<UserRole>? visibleForRoles;

  const DrawerItem({
    required this.title,
    required this.icon,
    this.route,
    this.onTap,
    this.trailing,
    this.permission,
    this.visibleForRoles,
  });
}

class CompactAppDrawer extends ConsumerWidget {
  final List<DrawerItem>? items;

  const CompactAppDrawer({
    super.key,
    this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    
    return NavigationDrawer(
      children: [
        currentUser.when(
          data: (user) => DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    (user?.name ?? 'U').substring(0, 1).toUpperCase(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user?.name ?? 'User',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  user?.email ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          loading: () => const DrawerHeader(
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, __) => const DrawerHeader(
            child: Center(child: Text('Error loading user')),
          ),
        ),
        if (items != null) ...items!.map(_buildNavigationDrawerDestination),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
        ),
      ],
    );
  }

  NavigationDrawerDestination _buildNavigationDrawerDestination(DrawerItem item) {
    return NavigationDrawerDestination(
      icon: Icon(item.icon),
      label: Text(item.title),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_constants.dart';
import '../../../../app/constants/app_colors.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  int _selectedIndex = 0;

  final List<DashboardItem> _dashboardItems = [
    DashboardItem(
      title: 'Sales Today',
      value: 'Rp 2,450,000',
      subtitle: '+12.5% from yesterday',
      icon: Icons.trending_up,
      color: AppColors.success,
      onTap: () {},
    ),
    DashboardItem(
      title: 'Total Products',
      value: '1,234',
      subtitle: '45 low stock',
      icon: Icons.inventory_2_outlined,
      color: AppColors.info,
      onTap: () {},
    ),
    DashboardItem(
      title: 'Transactions',
      value: '89',
      subtitle: 'Today',
      icon: Icons.receipt_long_outlined,
      color: AppColors.primary,
      onTap: () {},
    ),
    DashboardItem(
      title: 'Customers',
      value: '1,567',
      subtitle: '23 new this week',
      icon: Icons.people_outline,
      color: AppColors.tertiary,
      onTap: () {},
    ),
  ];

  final List<QuickAction> _quickActions = [
    QuickAction(
      title: 'New Sale',
      icon: Icons.point_of_sale,
      color: AppColors.primary,
      onTap: () {},
    ),
    QuickAction(
      title: 'Add Product',
      icon: Icons.add_box_outlined,
      color: AppColors.success,
      onTap: () {},
    ),
    QuickAction(
      title: 'View Reports',
      icon: Icons.analytics_outlined,
      color: AppColors.info,
      onTap: () {},
    ),
    QuickAction(
      title: 'Manage Staff',
      icon: Icons.people_alt_outlined,
      color: AppColors.tertiary,
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark 
          ? AppColors.backgroundDark 
          : AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark 
            ? AppColors.surfaceDark 
            : AppColors.surface,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning!',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDark 
                    ? AppColors.textSecondaryDark 
                    : AppColors.textSecondary,
              ),
            ),
            Text(
              'ExVen Store', // TODO: Get from current tenant/outlet
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark 
                    ? AppColors.textPrimaryDark 
                    : AppColors.textPrimary,
              ),
            ),
          ],
        ),
        actions: [
          // Notifications
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: AppColors.onError,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              // TODO: Show notifications
            },
          ),
          
          // Profile Menu
          PopupMenuButton<String>(
            icon: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary,
              child: Text(
                'A', // TODO: Get from user data
                style: TextStyle(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            onSelected: (value) {
              switch (value) {
                case 'profile':
                  // TODO: Navigate to profile
                  break;
                case 'settings':
                  // TODO: Navigate to settings
                  break;
                case 'logout':
                  _showLogoutDialog();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profile',
                child: ListTile(
                  leading: Icon(Icons.person_outline),
                  title: Text('Profile'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text('Settings'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout, color: AppColors.error),
                  title: Text('Logout', style: TextStyle(color: AppColors.error)),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dashboard Stats
            Text(
              'Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark 
                    ? AppColors.textPrimaryDark 
                    : AppColors.textPrimary,
              ),
            ),
            
            const SizedBox(height: 16),
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _dashboardItems.length,
              itemBuilder: (context, index) {
                final item = _dashboardItems[index];
                return _buildDashboardCard(item, isDark);
              },
            ),
            
            const SizedBox(height: 32),
            
            // Quick Actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark 
                    ? AppColors.textPrimaryDark 
                    : AppColors.textPrimary,
              ),
            ),
            
            const SizedBox(height: 16),
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _quickActions.length,
              itemBuilder: (context, index) {
                final action = _quickActions[index];
                return _buildQuickActionCard(action, isDark);
              },
            ),
            
            const SizedBox(height: 32),
            
            // Recent Transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark 
                        ? AppColors.textPrimaryDark 
                        : AppColors.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to all transactions
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            _buildRecentTransactions(isDark),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(DashboardItem item, bool isDark) {
    return Card(
      elevation: 2,
      shadowColor: AppColors.shadowColor,
      color: isDark 
          ? AppColors.surfaceDark 
          : AppColors.surface,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    item.icon,
                    color: item.color,
                    size: 24,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.trending_up,
                    color: AppColors.success,
                    size: 16,
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              Text(
                item.value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark 
                      ? AppColors.textPrimaryDark 
                      : AppColors.textPrimary,
                ),
              ),
              
              const SizedBox(height: 4),
              
              Text(
                item.title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark 
                      ? AppColors.textSecondaryDark 
                      : AppColors.textSecondary,
                ),
              ),
              
              const Spacer(),
              
              Text(
                item.subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.success,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(QuickAction action, bool isDark) {
    return Card(
      elevation: 1,
      shadowColor: AppColors.shadowColor,
      color: isDark 
          ? AppColors.surfaceDark 
          : AppColors.surface,
      child: InkWell(
        onTap: action.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: action.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  action.icon,
                  color: action.color,
                  size: 20,
                ),
              ),
              
              const SizedBox(width: 12),
              
              Expanded(
                child: Text(
                  action.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark 
                        ? AppColors.textPrimaryDark 
                        : AppColors.textPrimary,
                  ),
                ),
              ),
              
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: isDark 
                    ? AppColors.textSecondaryDark 
                    : AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentTransactions(bool isDark) {
    // Mock recent transactions data
    final transactions = [
      {'id': 'TXN-001', 'customer': 'John Doe', 'amount': 'Rp 125,000', 'time': '2 min ago'},
      {'id': 'TXN-002', 'customer': 'Jane Smith', 'amount': 'Rp 75,500', 'time': '15 min ago'},
      {'id': 'TXN-003', 'customer': 'Bob Wilson', 'amount': 'Rp 200,000', 'time': '32 min ago'},
    ];

    return Card(
      elevation: 1,
      shadowColor: AppColors.shadowColor,
      color: isDark 
          ? AppColors.surfaceDark 
          : AppColors.surface,
      child: Column(
        children: transactions.map((transaction) {
          final isLast = transaction == transactions.last;
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Icon(
                    Icons.receipt_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                title: Text(
                  transaction['customer']!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDark 
                        ? AppColors.textPrimaryDark 
                        : AppColors.textPrimary,
                  ),
                ),
                subtitle: Text(
                  transaction['id']! + ' • ' + transaction['time']!,
                  style: TextStyle(
                    color: isDark 
                        ? AppColors.textSecondaryDark 
                        : AppColors.textSecondary,
                  ),
                ),
                trailing: Text(
                  transaction['amount']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark 
                        ? AppColors.textPrimaryDark 
                        : AppColors.textPrimary,
                  ),
                ),
                onTap: () {
                  // TODO: Navigate to transaction details
                },
              ),
              if (!isLast) const Divider(height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showLogoutDialog() {
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
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement logout logic
              context.go('/login');
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class DashboardItem {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  DashboardItem({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class QuickAction {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  QuickAction({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
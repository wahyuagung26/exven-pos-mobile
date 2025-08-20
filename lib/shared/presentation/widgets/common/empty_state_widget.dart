import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionLabel;
  final Widget? customAction;
  final Color? iconColor;
  final double iconSize;
  final EdgeInsetsGeometry padding;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.onAction,
    this.actionLabel,
    this.customAction,
    this.iconColor,
    this.iconSize = 80.0,
    this.padding = const EdgeInsets.all(32.0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: iconColor ?? theme.colorScheme.outline,
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _buildAction(context),
        ],
      ),
    );
  }

  Widget _buildAction(BuildContext context) {
    if (customAction != null) {
      return customAction!;
    }

    if (onAction != null && actionLabel != null) {
      return FilledButton(
        onPressed: onAction,
        child: Text(actionLabel!),
      );
    }

    return const SizedBox.shrink();
  }
}

class SearchEmptyStateWidget extends StatelessWidget {
  final String query;
  final VoidCallback? onClearSearch;

  const SearchEmptyStateWidget({
    super.key,
    required this.query,
    this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      title: 'No results found',
      message: 'No items match your search for "$query".\nTry different keywords.',
      icon: Icons.search_off_outlined,
      actionLabel: 'Clear Search',
      onAction: onClearSearch,
    );
  }
}

class ProductsEmptyStateWidget extends StatelessWidget {
  final VoidCallback? onAddProduct;

  const ProductsEmptyStateWidget({
    super.key,
    this.onAddProduct,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      title: 'No products yet',
      message: 'Start by adding your first product to begin selling.',
      icon: Icons.inventory_2_outlined,
      actionLabel: 'Add Product',
      onAction: onAddProduct,
    );
  }
}

class CustomersEmptyStateWidget extends StatelessWidget {
  final VoidCallback? onAddCustomer;

  const CustomersEmptyStateWidget({
    super.key,
    this.onAddCustomer,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      title: 'No customers yet',
      message: 'Add customers to track their purchase history and preferences.',
      icon: Icons.people_outline,
      actionLabel: 'Add Customer',
      onAction: onAddCustomer,
    );
  }
}

class TransactionsEmptyStateWidget extends StatelessWidget {
  final VoidCallback? onNewSale;

  const TransactionsEmptyStateWidget({
    super.key,
    this.onNewSale,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      title: 'No transactions yet',
      message: 'Your sales history will appear here once you make your first sale.',
      icon: Icons.receipt_outlined,
      actionLabel: 'New Sale',
      onAction: onNewSale,
    );
  }
}

class ReportsEmptyStateWidget extends StatelessWidget {
  final VoidCallback? onViewHelp;

  const ReportsEmptyStateWidget({
    super.key,
    this.onViewHelp,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      title: 'No data to display',
      message: 'Reports will be generated once you have sales data.',
      icon: Icons.bar_chart_outlined,
      actionLabel: 'Learn More',
      onAction: onViewHelp,
    );
  }
}

class OfflineEmptyStateWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const OfflineEmptyStateWidget({
    super.key,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      title: 'You\'re offline',
      message: 'Connect to the internet to see your data.',
      icon: Icons.cloud_off_outlined,
      actionLabel: 'Retry',
      onAction: onRetry,
    );
  }
}

class InlineEmptyStateWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final double height;

  const InlineEmptyStateWidget({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.height = 120.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      height: height,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
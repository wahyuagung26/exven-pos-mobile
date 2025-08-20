import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/extensions/context_extensions.dart';
import '../../../utils/helpers/localization_helper.dart';

/// A demonstration widget showing various localization features
class LocalizationDemoWidget extends ConsumerWidget {
  const LocalizationDemoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(currentLocaleProvider);
    final now = DateTime.now();
    final sampleAmount = 1234567.89;
    final sampleNumber = 9876543;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.language,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Localization Demo',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Chip(
                  label: Text(LocalizationHelper.getLocaleDisplayName(currentLocale)),
                  avatar: _buildFlag(currentLocale),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Basic translations
            _buildDemoRow(
              context: context,
              label: 'App Name:',
              value: context.l10n.appName,
              icon: Icons.apps,
            ),
            
            _buildDemoRow(
              context: context,
              label: 'Loading text:',
              value: context.l10n.loading,
              icon: Icons.hourglass_empty,
            ),
            
            _buildDemoRow(
              context: context,
              label: 'Success message:',
              value: context.l10n.success,
              icon: Icons.check_circle,
            ),
            
            const Divider(),
            
            // Number formatting
            _buildDemoRow(
              context: context,
              label: 'Currency format:',
              value: context.formatCurrency(sampleAmount),
              icon: Icons.attach_money,
            ),
            
            _buildDemoRow(
              context: context,
              label: 'Number format:',
              value: context.formatNumber(sampleNumber),
              icon: Icons.format_list_numbered,
            ),
            
            const Divider(),
            
            // Date/Time formatting
            _buildDemoRow(
              context: context,
              label: 'Date format:',
              value: context.formatDate(now),
              icon: Icons.calendar_today,
            ),
            
            _buildDemoRow(
              context: context,
              label: 'Time format:',
              value: context.formatTime(now),
              icon: Icons.access_time,
            ),
            
            _buildDemoRow(
              context: context,
              label: 'DateTime format:',
              value: context.formatDateTime(now),
              icon: Icons.schedule,
            ),
            
            const Divider(),
            
            // Business terms
            _buildDemoRow(
              context: context,
              label: 'POS terms:',
              value: '${context.l10n.products} | ${context.l10n.customers} | ${context.l10n.transactions}',
              icon: Icons.store,
            ),
            
            _buildDemoRow(
              context: context,
              label: 'Payment methods:',
              value: '${context.l10n.cash} | ${context.l10n.card} | ${context.l10n.transfer}',
              icon: Icons.payment,
            ),
            
            const SizedBox(height: 16),
            
            // Sample transaction receipt
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${context.l10n.transaction} ${context.l10n.receipt}',
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildReceiptRow(context, context.l10n.subtotal, 950000),
                  _buildReceiptRow(context, context.l10n.discount, -50000),
                  _buildReceiptRow(context, context.l10n.tax, 90000),
                  const Divider(),
                  _buildReceiptRow(
                    context,
                    context.l10n.total,
                    990000,
                    isTotal: true,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${context.l10n.payment}: ${context.l10n.cash}',
                    style: context.textTheme.bodySmall,
                  ),
                  Text(
                    '${context.formatDateTime(now)}',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoRow({
    required BuildContext context,
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: context.colorScheme.primary),
          const SizedBox(width: 8),
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: context.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptRow(
    BuildContext context,
    String label,
    double amount, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  )
                : context.textTheme.bodySmall,
          ),
          Text(
            context.formatCurrency(amount),
            style: isTotal
                ? context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  )
                : context.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildFlag(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return const Text('🇺🇸', style: TextStyle(fontSize: 16));
      case 'id':
        return const Text('🇮🇩', style: TextStyle(fontSize: 16));
      default:
        return const Icon(Icons.language, size: 16);
    }
  }
}

/// A simple receipt widget showcasing localization
class LocalizedReceiptWidget extends ConsumerWidget {
  final List<Map<String, dynamic>> items;
  final double subtotal;
  final double discount;
  final double tax;
  final String paymentMethod;

  const LocalizedReceiptWidget({
    super.key,
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = subtotal - discount + tax;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.outline.withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.receipt_long,
                color: context.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                '${context.l10n.transaction} ${context.l10n.receipt}',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Items
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item['name'] as String,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      '${item['quantity']}x ${context.formatCurrency(item['price'] as double)}',
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
              )),
          
          const Divider(height: 24),
          
          // Totals
          _buildTotalRow(context, context.l10n.subtotal, subtotal),
          if (discount > 0)
            _buildTotalRow(
              context,
              context.l10n.discount,
              -discount,
              color: context.colorScheme.error,
            ),
          if (tax > 0) _buildTotalRow(context, context.l10n.tax, tax),
          
          const Divider(height: 16),
          
          _buildTotalRow(
            context,
            context.l10n.total,
            total,
            isTotal: true,
          ),
          
          const SizedBox(height: 12),
          
          // Payment info
          Text(
            '${context.l10n.payment}: $paymentMethod',
            style: context.textTheme.bodySmall,
          ),
          
          Text(
            context.formatDateTime(DateTime.now()),
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(
    BuildContext context,
    String label,
    double amount, {
    bool isTotal = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  )
                : context.textTheme.bodyMedium,
          ),
          Text(
            context.formatCurrency(amount),
            style: (isTotal
                    ? context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                    : context.textTheme.bodyMedium)
                ?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
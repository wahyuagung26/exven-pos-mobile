import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/presentation/widgets/common/language_selector_widget.dart';
import '../../../../shared/presentation/widgets/layout/app_scaffold.dart';
import '../../../../shared/utils/extensions/context_extensions.dart';
import '../../../../shared/utils/helpers/localization_helper.dart';

/// Settings page demonstrating internationalization features
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(currentLocaleProvider);
    
    return AppScaffold(
      title: context.l10n.settings,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Selection Section
            _buildSectionCard(
              context: context,
              title: context.l10n.language,
              icon: Icons.translate,
              children: [
                ListTile(
                  title: Text(context.l10n.language),
                  subtitle: Text(LocalizationHelper.getLocaleDisplayName(currentLocale)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => LanguageSelectionDialog.show(context),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: LanguageSelectorWidget(
                    showAsDropdown: false,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Currency and Formatting Section
            _buildSectionCard(
              context: context,
              title: 'Currency & Formatting',
              icon: Icons.monetization_on,
              children: [
                ListTile(
                  title: Text(context.l10n.currency),
                  subtitle: Text(currentLocale.languageCode == 'id' ? 'Indonesian Rupiah (IDR)' : 'US Dollar (USD)'),
                  trailing: Text(context.formatCurrency(1234567.89)),
                ),
                ListTile(
                  title: Text(context.l10n.dateFormat),
                  subtitle: Text(context.formatDate(DateTime.now())),
                ),
                ListTile(
                  title: Text(context.l10n.timeFormat),
                  subtitle: Text(context.formatTime(DateTime.now())),
                ),
                ListTile(
                  title: Text('Number Format'),
                  subtitle: Text(context.formatNumber(1234567)),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Demo Section - Sample Translations
            _buildSectionCard(
              context: context,
              title: 'Translation Demo',
              icon: Icons.quiz,
              children: [
                _buildDemoListTile(
                  context: context,
                  title: 'Authentication',
                  items: [
                    context.l10n.login,
                    context.l10n.logout,
                    context.l10n.email,
                    context.l10n.password,
                  ],
                ),
                _buildDemoListTile(
                  context: context,
                  title: 'Navigation',
                  items: [
                    context.l10n.dashboard,
                    context.l10n.products,
                    context.l10n.customers,
                    context.l10n.transactions,
                    context.l10n.reports,
                  ],
                ),
                _buildDemoListTile(
                  context: context,
                  title: 'Actions',
                  items: [
                    context.l10n.save,
                    context.l10n.delete,
                    context.l10n.cancel,
                    context.l10n.confirm,
                  ],
                ),
                _buildDemoListTile(
                  context: context,
                  title: 'POS Terms',
                  items: [
                    context.l10n.total,
                    context.l10n.subtotal,
                    context.l10n.discount,
                    context.l10n.tax,
                    context.l10n.payment,
                  ],
                ),
                _buildDemoListTile(
                  context: context,
                  title: 'Payment Methods',
                  items: [
                    context.l10n.cash,
                    context.l10n.card,
                    context.l10n.transfer,
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Error Messages Demo
            _buildSectionCard(
              context: context,
              title: 'Error Messages Demo',
              icon: Icons.error_outline,
              children: [
                _buildErrorDemoTile(context, 'network_error', context.l10n.networkError),
                _buildErrorDemoTile(context, 'server_error', context.l10n.serverError),
                _buildErrorDemoTile(context, 'validation_error', context.l10n.validationError),
                _buildErrorDemoTile(context, 'unauthorized_access', context.l10n.unauthorizedAccess),
                _buildErrorDemoTile(context, 'not_found', context.l10n.notFound),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Quick Language Toggle Demo
            Center(
              child: Column(
                children: [
                  Text(
                    'Quick Language Toggle',
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  const LanguageToggleButton(),
                  const SizedBox(height: 8),
                  Text(
                    'Current: ${LocalizationHelper.getLocaleDisplayName(currentLocale)}',
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: context.colorScheme.primary),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          ...children,
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildDemoListTile({
    required BuildContext context,
    required String title,
    required List<String> items,
  }) {
    return ExpansionTile(
      title: Text(title),
      children: items
          .map((item) => ListTile(
                dense: true,
                title: Text(item),
                leading: const Icon(Icons.translate, size: 16),
              ))
          .toList(),
    );
  }

  Widget _buildErrorDemoTile(BuildContext context, String errorKey, String message) {
    return ListTile(
      dense: true,
      title: Text(errorKey),
      subtitle: Text(message),
      leading: Icon(
        Icons.error_outline,
        color: context.colorScheme.error,
        size: 16,
      ),
    );
  }
}
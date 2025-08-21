import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        children: [
          // Profile section
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Toko Demo',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'admin@jagokasir.com',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          // Settings items
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Informasi Toko'),
            subtitle: const Text('Nama, alamat, dan kontak'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to store info
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt),
            title: const Text('Pengaturan Struk'),
            subtitle: const Text('Header, footer, dan format'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to receipt settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Metode Pembayaran'),
            subtitle: const Text('Tunai, transfer, dan lainnya'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to payment methods
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Kategori Produk'),
            subtitle: const Text('Kelola kategori produk'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to categories
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Pengguna'),
            subtitle: const Text('Kelola pengguna dan hak akses'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to users
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text('Backup & Restore'),
            subtitle: const Text('Backup dan restore data'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to backup
            },
          ),
          ListTile(
            leading: const Icon(Icons.sync),
            title: const Text('Sinkronisasi'),
            subtitle: const Text('Sinkronisasi dengan cloud'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to sync
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Tentang'),
            subtitle: const Text('Versi 1.0.0'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'JagoKasir',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2024 JagoKasir',
                children: [
                  const SizedBox(height: 16),
                  const Text('Sistem POS offline-first untuk UMKM Indonesia'),
                ],
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Keluar', style: TextStyle(color: Colors.red)),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Konfirmasi'),
                  content: const Text('Apakah Anda yakin ingin keluar?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Implement logout
                        context.go('/login');
                      },
                      child: const Text('Keluar', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
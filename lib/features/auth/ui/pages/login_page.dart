import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/ui/widgets/loading_widget.dart';
import '../../../../shared/utils/extensions.dart';
import '../../providers.dart';
import '../widgets/login_form.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    // Listen to state changes for navigation/snackbars
    ref.listen(authStateProvider, (previous, next) {
      next.whenOrNull(
        error: (message) => context.showErrorSnackBar(message),
        authenticated: (_) {
          // Navigation will be handled by router
          context.showSuccessSnackBar('Login successful!');
        },
      );
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo/App Name
              Icon(
                Icons.point_of_sale,
                size: 80,
                color: context.colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'POS System',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to your account',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              // Login Form
              authState.when(
                initial: () => const LoginForm(),
                loading: () => const LoadingWidget(message: 'Signing in...'),
                authenticated: (_) => const LoadingWidget(message: 'Redirecting...'),
                unauthenticated: () => const LoginForm(),
                error: (_) => const LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
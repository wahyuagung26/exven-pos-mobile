import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/providers.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/auth/ui/pages/splash_page.dart';
import '../shared/utils/constants/route_constants.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return GoRouter(
    initialLocation: RouteConstants.splash,
    redirect: (context, state) {
      final isAuthenticated = authState.maybeWhen(
        authenticated: (_) => true,
        orElse: () => false,
      );
      
      final isAuthenticating = authState.maybeWhen(
        loading: () => true,
        initial: () => true,
        orElse: () => false,
      );
      
      final isOnSplash = state.matchedLocation == RouteConstants.splash;
      final isOnLogin = state.matchedLocation == RouteConstants.login;
      
      // If still checking auth, stay on splash
      if (isAuthenticating && isOnSplash) {
        return null;
      }
      
      // If not authenticated, redirect to login (but not from splash)
      if (!isAuthenticated && !isOnLogin && !isOnSplash) {
        return RouteConstants.login;
      }
      
      // If unauthenticated and on splash, redirect to login
      if (authState.maybeWhen(unauthenticated: () => true, orElse: () => false) && isOnSplash) {
        return RouteConstants.login;
      }
      
      // If authenticated and on auth pages, redirect to dashboard
      if (isAuthenticated && (isOnLogin || isOnSplash)) {
        return RouteConstants.dashboard;
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: RouteConstants.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteConstants.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteConstants.dashboard,
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
    ],
  );
});

// Temporary dashboard page
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authStateProvider.notifier).logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${user?.name ?? 'User'}!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Role: ${user?.role.name.toUpperCase() ?? 'Unknown'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Tenant ID: ${user?.tenantId ?? 'Unknown'}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

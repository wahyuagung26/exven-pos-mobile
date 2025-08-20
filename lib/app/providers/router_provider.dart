import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../shared/presentation/pages/not_found_page.dart';
import '../../shared/presentation/pages/no_internet_page.dart';
import '../constants/app_constants.dart';

// Route name constants
class AppRoutes {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String dashboard = 'dashboard';
  static const String products = 'products';
  static const String customers = 'customers';
  static const String transactions = 'transactions';
  static const String reports = 'reports';
  static const String settings = 'settings';
  static const String profile = 'profile';
  static const String notFound = 'not_found';
  static const String noInternet = 'no_internet';
}

// Router key for global navigation
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

// Auth state provider placeholder - will be replaced with actual auth implementation
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier();
});

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = true,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(const AuthState()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // Simulate auth check - replace with actual implementation
    await Future.delayed(const Duration(seconds: 1));
    
    // TODO: Check if user is authenticated from secure storage
    // For now, default to unauthenticated
    state = state.copyWith(
      isAuthenticated: false,
      isLoading: false,
    );
  }

  void login() {
    state = state.copyWith(
      isAuthenticated: true,
      isLoading: false,
      error: null,
    );
  }

  void logout() {
    state = state.copyWith(
      isAuthenticated: false,
      isLoading: false,
      error: null,
    );
  }
}

// Router provider with authentication guards and error handling
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: AppConstants.enableDebugMode,
    initialLocation: '/splash',
    redirect: (BuildContext context, GoRouterState state) {
      final location = state.uri.toString();
      final isAuthLoading = authState.isLoading;
      final isAuthenticated = authState.isAuthenticated;

      // Show splash while checking authentication
      if (isAuthLoading) {
        return location == '/splash' ? null : '/splash';
      }

      // Define public routes that don't require authentication
      final publicRoutes = ['/splash', '/login', '/no-internet', '/not-found'];
      final isPublicRoute = publicRoutes.contains(location);

      // Redirect logic based on authentication status
      if (!isAuthenticated) {
        // User not authenticated
        if (isPublicRoute) {
          // Allow access to public routes
          if (location == '/splash') {
            // Let splash page handle the navigation to login
            return null;
          }
          return null;
        } else {
          // Redirect to login for protected routes
          return '/login';
        }
      } else {
        // User is authenticated
        if (location == '/login' || location == '/splash') {
          // Redirect authenticated users away from login/splash
          return '/dashboard';
        }
        // Allow access to protected routes
        return null;
      }
    },
    routes: [
      // Splash Route
      GoRoute(
        path: '/splash',
        name: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),

      // Authentication Routes
      GoRoute(
        path: '/login',
        name: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),

      // Main App Shell with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) {
          // Check if current route should show bottom navigation
          final location = state.uri.toString();
          final showBottomNav = _shouldShowBottomNavigation(location);
          
          if (showBottomNav) {
            return MainShell(child: child);
          }
          
          return child;
        },
        routes: [
          // Dashboard Route
          GoRoute(
            path: '/dashboard',
            name: AppRoutes.dashboard,
            builder: (context, state) => const DashboardPage(),
          ),

          // Products Routes
          GoRoute(
            path: '/products',
            name: AppRoutes.products,
            builder: (context, state) => const PlaceholderPage(title: 'Products'),
            routes: [
              GoRoute(
                path: '/:id',
                name: 'product_detail',
                builder: (context, state) {
                  final productId = state.pathParameters['id']!;
                  return PlaceholderPage(title: 'Product Details: $productId');
                },
              ),
            ],
          ),

          // Customers Route
          GoRoute(
            path: '/customers',
            name: AppRoutes.customers,
            builder: (context, state) => const PlaceholderPage(title: 'Customers'),
          ),

          // Transactions Route
          GoRoute(
            path: '/transactions',
            name: AppRoutes.transactions,
            builder: (context, state) => const PlaceholderPage(title: 'Transactions'),
          ),

          // Reports Route
          GoRoute(
            path: '/reports',
            name: AppRoutes.reports,
            builder: (context, state) => const PlaceholderPage(title: 'Reports'),
          ),

          // Settings Route
          GoRoute(
            path: '/settings',
            name: AppRoutes.settings,
            builder: (context, state) => const PlaceholderPage(title: 'Settings'),
          ),

          // Profile Route
          GoRoute(
            path: '/profile',
            name: AppRoutes.profile,
            builder: (context, state) => const PlaceholderPage(title: 'Profile'),
          ),
        ],
      ),

      // Utility Routes
      GoRoute(
        path: '/no-internet',
        name: AppRoutes.noInternet,
        builder: (context, state) => const NoInternetPage(),
      ),
    ],

    // Error handling
    errorBuilder: (context, state) => const NotFoundPage(),

    // Handle deep link validation
    onException: (context, state, router) {
      // Log navigation errors in debug mode
      if (AppConstants.enableDebugMode) {
        debugPrint('Router Exception: ${state.error}');
      }
    },
  );
});

// Helper function to determine if bottom navigation should be shown
bool _shouldShowBottomNavigation(String location) {
  final mainRoutes = [
    '/dashboard',
    '/products',
    '/customers', 
    '/transactions',
    '/reports',
  ];
  
  return mainRoutes.any((route) => location.startsWith(route));
}

// Main shell widget with bottom navigation
class MainShell extends StatefulWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final List<NavigationDestination> _destinations = [
    const NavigationDestination(
      icon: Icon(Icons.dashboard_outlined),
      selectedIcon: Icon(Icons.dashboard),
      label: 'Dashboard',
    ),
    const NavigationDestination(
      icon: Icon(Icons.inventory_2_outlined),
      selectedIcon: Icon(Icons.inventory_2),
      label: 'Products',
    ),
    const NavigationDestination(
      icon: Icon(Icons.people_outline),
      selectedIcon: Icon(Icons.people),
      label: 'Customers',
    ),
    const NavigationDestination(
      icon: Icon(Icons.receipt_long_outlined),
      selectedIcon: Icon(Icons.receipt_long),
      label: 'Sales',
    ),
    const NavigationDestination(
      icon: Icon(Icons.analytics_outlined),
      selectedIcon: Icon(Icons.analytics),
      label: 'Reports',
    ),
  ];

  final List<String> _routes = [
    '/dashboard',
    '/products',
    '/customers',
    '/transactions',
    '/reports',
  ];

  @override
  Widget build(BuildContext context) {
    // Update selected index based on current location
    final location = GoRouterState.of(context).uri.toString();
    _selectedIndex = _getIndexFromLocation(location);

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          context.go(_routes[index]);
        },
        destinations: _destinations,
      ),
    );
  }

  int _getIndexFromLocation(String location) {
    for (int i = 0; i < _routes.length; i++) {
      if (location.startsWith(_routes[i])) {
        return i;
      }
    }
    return 0; // Default to dashboard
  }
}

// Placeholder page widget for routes that haven't been implemented yet
class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'This page is under construction',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                context.go('/dashboard');
              },
              icon: const Icon(Icons.home),
              label: const Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}

// Extension to make navigation easier
extension GoRouterExtension on BuildContext {
  void goToProducts() => go('/products');
  void goToCustomers() => go('/customers');
  void goToTransactions() => go('/transactions');
  void goToReports() => go('/reports');
  void goToSettings() => go('/settings');
  void goToProfile() => go('/profile');
  void goToDashboard() => go('/dashboard');
  void goToLogin() => go('/login');
  void goToNoInternet() => go('/no-internet');
}
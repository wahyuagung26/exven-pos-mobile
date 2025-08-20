/// Route names and paths for navigation in the POS application
/// 
/// This file contains all route-related constants for the GoRouter navigation
/// system, including route names, paths, and navigation helpers for the
/// multi-tenant POS system.

/// Route Names
/// Used as identifiers for navigation and routing
class RouteNames {
  // Authentication Routes
  static const String splash = 'splash';
  static const String login = 'login';
  static const String forgotPassword = 'forgot-password';
  static const String resetPassword = 'reset-password';
  static const String changePassword = 'change-password';
  
  // Main App Routes
  static const String dashboard = 'dashboard';
  static const String home = 'home';
  
  // Product Management Routes
  static const String products = 'products';
  static const String productDetail = 'product-detail';
  static const String productCreate = 'product-create';
  static const String productEdit = 'product-edit';
  static const String productCategories = 'product-categories';
  static const String categoryDetail = 'category-detail';
  static const String categoryCreate = 'category-create';
  static const String categoryEdit = 'category-edit';
  static const String stockManagement = 'stock-management';
  static const String stockOpname = 'stock-opname';
  static const String stockTransfer = 'stock-transfer';
  static const String stockAdjustment = 'stock-adjustment';
  
  // Customer Management Routes
  static const String customers = 'customers';
  static const String customerDetail = 'customer-detail';
  static const String customerCreate = 'customer-create';
  static const String customerEdit = 'customer-edit';
  static const String customerSearch = 'customer-search';
  
  // Transaction Routes
  static const String transactions = 'transactions';
  static const String transactionDetail = 'transaction-detail';
  static const String transactionHistory = 'transaction-history';
  static const String transactionReceipt = 'transaction-receipt';
  static const String pointOfSale = 'point-of-sale';
  static const String pos = 'pos';
  static const String cart = 'cart';
  static const String payment = 'payment';
  static const String refund = 'refund';
  
  // Report Routes
  static const String reports = 'reports';
  static const String salesReport = 'sales-report';
  static const String inventoryReport = 'inventory-report';
  static const String customerReport = 'customer-report';
  static const String profitReport = 'profit-report';
  static const String dailySummary = 'daily-summary';
  static const String monthlySummary = 'monthly-summary';
  
  // User Management Routes
  static const String users = 'users';
  static const String userDetail = 'user-detail';
  static const String userCreate = 'user-create';
  static const String userEdit = 'user-edit';
  static const String profile = 'profile';
  static const String editProfile = 'edit-profile';
  
  // Outlet Management Routes
  static const String outlets = 'outlets';
  static const String outletDetail = 'outlet-detail';
  static const String outletCreate = 'outlet-create';
  static const String outletEdit = 'outlet-edit';
  static const String outletSwitch = 'outlet-switch';
  static const String outletSettings = 'outlet-settings';
  
  // Settings Routes
  static const String settings = 'settings';
  static const String generalSettings = 'general-settings';
  static const String printerSettings = 'printer-settings';
  static const String receiptSettings = 'receipt-settings';
  static const String paymentSettings = 'payment-settings';
  static const String notificationSettings = 'notification-settings';
  static const String syncSettings = 'sync-settings';
  static const String securitySettings = 'security-settings';
  
  // Tenant Management Routes (Owner only)
  static const String tenantSettings = 'tenant-settings';
  static const String subscription = 'subscription';
  static const String billing = 'billing';
  static const String planUpgrade = 'plan-upgrade';
  
  // System Routes
  static const String about = 'about';
  static const String help = 'help';
  static const String support = 'support';
  static const String feedback = 'feedback';
  static const String logs = 'logs';
  static const String sync = 'sync';
  
  // Error Routes
  static const String notFound = 'not-found';
  static const String error = 'error';
  static const String noInternet = 'no-internet';
  static const String maintenance = 'maintenance';
  static const String unauthorized = 'unauthorized';
  static const String forbidden = 'forbidden';
}

/// Route Paths
/// URL paths for navigation
class RoutePaths {
  // Authentication Paths
  static const String splash = '/splash';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String changePassword = '/change-password';
  
  // Main App Paths
  static const String dashboard = '/dashboard';
  static const String home = '/';
  
  // Product Management Paths
  static const String products = '/products';
  static const String productDetail = '/products/:id';
  static const String productCreate = '/products/create';
  static const String productEdit = '/products/:id/edit';
  static const String productCategories = '/categories';
  static const String categoryDetail = '/categories/:id';
  static const String categoryCreate = '/categories/create';
  static const String categoryEdit = '/categories/:id/edit';
  static const String stockManagement = '/stock';
  static const String stockOpname = '/stock/opname';
  static const String stockTransfer = '/stock/transfer';
  static const String stockAdjustment = '/stock/adjustment';
  
  // Customer Management Paths
  static const String customers = '/customers';
  static const String customerDetail = '/customers/:id';
  static const String customerCreate = '/customers/create';
  static const String customerEdit = '/customers/:id/edit';
  static const String customerSearch = '/customers/search';
  
  // Transaction Paths
  static const String transactions = '/transactions';
  static const String transactionDetail = '/transactions/:id';
  static const String transactionHistory = '/transactions/history';
  static const String transactionReceipt = '/transactions/:id/receipt';
  static const String pointOfSale = '/pos';
  static const String pos = '/sale';
  static const String cart = '/cart';
  static const String payment = '/payment';
  static const String refund = '/refund/:id';
  
  // Report Paths
  static const String reports = '/reports';
  static const String salesReport = '/reports/sales';
  static const String inventoryReport = '/reports/inventory';
  static const String customerReport = '/reports/customers';
  static const String profitReport = '/reports/profit';
  static const String dailySummary = '/reports/daily';
  static const String monthlySummary = '/reports/monthly';
  
  // User Management Paths
  static const String users = '/users';
  static const String userDetail = '/users/:id';
  static const String userCreate = '/users/create';
  static const String userEdit = '/users/:id/edit';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  
  // Outlet Management Paths
  static const String outlets = '/outlets';
  static const String outletDetail = '/outlets/:id';
  static const String outletCreate = '/outlets/create';
  static const String outletEdit = '/outlets/:id/edit';
  static const String outletSwitch = '/outlets/switch';
  static const String outletSettings = '/outlets/:id/settings';
  
  // Settings Paths
  static const String settings = '/settings';
  static const String generalSettings = '/settings/general';
  static const String printerSettings = '/settings/printer';
  static const String receiptSettings = '/settings/receipt';
  static const String paymentSettings = '/settings/payment';
  static const String notificationSettings = '/settings/notifications';
  static const String syncSettings = '/settings/sync';
  static const String securitySettings = '/settings/security';
  
  // Tenant Management Paths
  static const String tenantSettings = '/tenant';
  static const String subscription = '/subscription';
  static const String billing = '/billing';
  static const String planUpgrade = '/subscription/upgrade';
  
  // System Paths
  static const String about = '/about';
  static const String help = '/help';
  static const String support = '/support';
  static const String feedback = '/feedback';
  static const String logs = '/logs';
  static const String sync = '/sync';
  
  // Error Paths
  static const String notFound = '/404';
  static const String error = '/error';
  static const String noInternet = '/no-internet';
  static const String maintenance = '/maintenance';
  static const String unauthorized = '/unauthorized';
  static const String forbidden = '/403';
}

/// Route Parameters
/// Parameter names used in dynamic routes
class RouteParams {
  static const String id = 'id';
  static const String userId = 'userId';
  static const String productId = 'productId';
  static const String customerId = 'customerId';
  static const String transactionId = 'transactionId';
  static const String categoryId = 'categoryId';
  static const String outletId = 'outletId';
  static const String reportType = 'reportType';
  static const String settingsType = 'settingsType';
}

/// Query Parameters
/// Common query parameter names
class RouteQuery {
  static const String page = 'page';
  static const String search = 'search';
  static const String filter = 'filter';
  static const String sort = 'sort';
  static const String tab = 'tab';
  static const String returnTo = 'returnTo';
  static const String mode = 'mode';
  static const String outlet = 'outlet';
  static const String category = 'category';
  static const String status = 'status';
  static const String dateFrom = 'dateFrom';
  static const String dateTo = 'dateTo';
}

/// Route Groups
/// Logical grouping of routes for permission checking
class RouteGroups {
  // Public routes (no authentication required)
  static const Set<String> publicRoutes = {
    RouteNames.splash,
    RouteNames.login,
    RouteNames.forgotPassword,
    RouteNames.resetPassword,
    RouteNames.noInternet,
    RouteNames.maintenance,
    RouteNames.error,
    RouteNames.notFound,
  };
  
  // Admin only routes
  static const Set<String> adminRoutes = {
    RouteNames.users,
    RouteNames.userCreate,
    RouteNames.userEdit,
    RouteNames.tenantSettings,
    RouteNames.subscription,
    RouteNames.billing,
    RouteNames.planUpgrade,
  };
  
  // Manager level routes
  static const Set<String> managerRoutes = {
    RouteNames.outlets,
    RouteNames.outletCreate,
    RouteNames.outletEdit,
    RouteNames.outletSettings,
    RouteNames.reports,
    RouteNames.salesReport,
    RouteNames.inventoryReport,
    RouteNames.customerReport,
    RouteNames.profitReport,
  };
  
  // Cashier accessible routes
  static const Set<String> cashierRoutes = {
    RouteNames.dashboard,
    RouteNames.pointOfSale,
    RouteNames.pos,
    RouteNames.cart,
    RouteNames.payment,
    RouteNames.products,
    RouteNames.productDetail,
    RouteNames.customers,
    RouteNames.customerDetail,
    RouteNames.customerSearch,
    RouteNames.transactions,
    RouteNames.transactionDetail,
    RouteNames.transactionHistory,
    RouteNames.transactionReceipt,
    RouteNames.profile,
    RouteNames.editProfile,
    RouteNames.settings,
  };
  
  // Settings routes
  static const Set<String> settingsRoutes = {
    RouteNames.settings,
    RouteNames.generalSettings,
    RouteNames.printerSettings,
    RouteNames.receiptSettings,
    RouteNames.paymentSettings,
    RouteNames.notificationSettings,
    RouteNames.syncSettings,
    RouteNames.securitySettings,
  };
}

/// Navigation Helpers
/// Helper functions for route navigation
class RouteHelpers {
  /// Build product detail path with ID
  static String productDetailPath(String productId) {
    return RoutePaths.productDetail.replaceAll(':id', productId);
  }
  
  /// Build customer detail path with ID
  static String customerDetailPath(String customerId) {
    return RoutePaths.customerDetail.replaceAll(':id', customerId);
  }
  
  /// Build transaction detail path with ID
  static String transactionDetailPath(String transactionId) {
    return RoutePaths.transactionDetail.replaceAll(':id', transactionId);
  }
  
  /// Build outlet detail path with ID
  static String outletDetailPath(String outletId) {
    return RoutePaths.outletDetail.replaceAll(':id', outletId);
  }
  
  /// Build user detail path with ID
  static String userDetailPath(String userId) {
    return RoutePaths.userDetail.replaceAll(':id', userId);
  }
  
  /// Build category detail path with ID
  static String categoryDetailPath(String categoryId) {
    return RoutePaths.categoryDetail.replaceAll(':id', categoryId);
  }
  
  /// Build transaction receipt path with ID
  static String transactionReceiptPath(String transactionId) {
    return RoutePaths.transactionReceipt.replaceAll(':id', transactionId);
  }
  
  /// Build refund path with transaction ID
  static String refundPath(String transactionId) {
    return RoutePaths.refund.replaceAll(':id', transactionId);
  }
  
  /// Check if route requires authentication
  static bool requiresAuth(String routeName) {
    return !RouteGroups.publicRoutes.contains(routeName);
  }
  
  /// Check if route requires admin permissions
  static bool requiresAdmin(String routeName) {
    return RouteGroups.adminRoutes.contains(routeName);
  }
  
  /// Check if route requires manager permissions
  static bool requiresManager(String routeName) {
    return RouteGroups.managerRoutes.contains(routeName) ||
           RouteGroups.adminRoutes.contains(routeName);
  }
  
  /// Get default route based on user role
  static String getDefaultRouteForRole(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
      case 'owner':
        return RouteNames.dashboard;
      case 'manager':
        return RouteNames.dashboard;
      case 'cashier':
        return RouteNames.pointOfSale;
      default:
        return RouteNames.dashboard;
    }
  }
}

/// Deep Link Configuration
/// Configuration for handling deep links and external navigation
class DeepLinkPaths {
  static const String productShare = '/share/product/:id';
  static const String transactionShare = '/share/transaction/:id';
  static const String promotionShare = '/share/promotion/:id';
  static const String referral = '/referral/:code';
  static const String resetPasswordToken = '/reset/:token';
  static const String invitation = '/invite/:token';
}

/// Route Metadata
/// Additional information about routes for navigation and UI
class RouteMetadata {
  final String title;
  final String? description;
  final String? icon;
  final bool showInNavigation;
  final bool requiresAuth;
  final List<String>? requiredPermissions;
  
  const RouteMetadata({
    required this.title,
    this.description,
    this.icon,
    this.showInNavigation = true,
    this.requiresAuth = true,
    this.requiredPermissions,
  });
}

/// Route configuration with metadata
final Map<String, RouteMetadata> routeMetadata = {
  RouteNames.dashboard: const RouteMetadata(
    title: 'Dashboard',
    description: 'Overview dan ringkasan bisnis',
    icon: 'dashboard',
  ),
  RouteNames.pointOfSale: const RouteMetadata(
    title: 'Point of Sale',
    description: 'Kasir dan penjualan',
    icon: 'point_of_sale',
  ),
  RouteNames.products: const RouteMetadata(
    title: 'Produk',
    description: 'Manajemen produk dan stok',
    icon: 'inventory',
    requiredPermissions: ['products.read'],
  ),
  RouteNames.customers: const RouteMetadata(
    title: 'Pelanggan',
    description: 'Manajemen data pelanggan',
    icon: 'people',
    requiredPermissions: ['customers.read'],
  ),
  RouteNames.transactions: const RouteMetadata(
    title: 'Transaksi',
    description: 'Riwayat dan detail transaksi',
    icon: 'receipt',
  ),
  RouteNames.reports: const RouteMetadata(
    title: 'Laporan',
    description: 'Analisis dan laporan bisnis',
    icon: 'analytics',
    requiredPermissions: ['reports.read'],
  ),
  RouteNames.settings: const RouteMetadata(
    title: 'Pengaturan',
    description: 'Konfigurasi aplikasi',
    icon: 'settings',
  ),
};
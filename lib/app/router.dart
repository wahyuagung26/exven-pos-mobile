import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../shared/utils/constants.dart';

final router = GoRouter(
  initialLocation: RouteConstants.splash,
  routes: [
    GoRoute(
      path: RouteConstants.splash,
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Splash Screen'),
        ),
      ),
    ),
    GoRoute(
      path: RouteConstants.login,
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Login Screen'),
        ),
      ),
    ),
    GoRoute(
      path: RouteConstants.dashboard,
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Dashboard Screen'),
        ),
      ),
    ),
  ],
);

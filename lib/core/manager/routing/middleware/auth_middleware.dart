import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:project_architecture/core/manager/routing/middleware/navigation_middleware.dart';
import 'package:project_architecture/core/manager/storage/storage_manager.dart';

/// Authentication middleware
///
/// Checks if user is authenticated before allowing access to private routes
/// Redirects to login if not authenticated
class AuthMiddleware extends NavigationMiddleware {
  final StorageManager _storage;
  final String loginRoute;
  final List<String> publicRoutes;

  const AuthMiddleware({
    required StorageManager storage,
    this.loginRoute = '/login',
    this.publicRoutes = const ['/login', '/splash', '/register', '/forgot-password'],
  }) : _storage = storage;

  @override
  Future<MiddlewareResult> execute(
    BuildContext context,
    GoRouterState state,
  ) async {
    final currentPath = state.matchedLocation;

    // Check if route is public
    if (_isPublicRoute(currentPath)) {
      return const MiddlewareResult.proceed();
    }

    // Check authentication
    final isAuthenticated = await _checkAuthentication();

    if (isAuthenticated) {
      return const MiddlewareResult.proceed();
    }

    // Not authenticated - redirect to login
    return MiddlewareResult.redirect(
      loginRoute,
      data: {'redirectTo': currentPath},
    );
  }

  /// Check if user is authenticated
  Future<bool> _checkAuthentication() async {
    try {
      final token = await _storage.readSecure('auth_token');
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Check if route is public (doesn't require authentication)
  bool _isPublicRoute(String path) {
    return publicRoutes.any((route) => path.startsWith(route));
  }

  @override
  int get priority => 10; // Execute first

  @override
  String get name => 'AuthMiddleware';
}

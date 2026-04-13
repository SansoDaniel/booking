import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Result of middleware execution
class MiddlewareResult {
  final bool canProceed;
  final String? redirectTo;
  final Map<String, dynamic>? data;

  const MiddlewareResult({
    required this.canProceed,
    this.redirectTo,
    this.data,
  });

  /// Allow navigation to proceed
  const MiddlewareResult.proceed() : this(canProceed: true);

  /// Redirect to another route
  const MiddlewareResult.redirect(String path, {Map<String, dynamic>? data})
      : this(canProceed: false, redirectTo: path, data: data);

  /// Block navigation
  const MiddlewareResult.block() : this(canProceed: false);
}

/// Abstract base class for navigation middleware
///
/// Middleware allows you to intercept navigation and execute logic
/// before the route is displayed (authentication, logging, analytics, etc.)
abstract class NavigationMiddleware {
  const NavigationMiddleware();

  /// Called before navigation occurs
  ///
  /// Return [MiddlewareResult.proceed()] to allow navigation
  /// Return [MiddlewareResult.redirect(path)] to redirect to another route
  /// Return [MiddlewareResult.block()] to prevent navigation
  Future<MiddlewareResult> execute(
    BuildContext context,
    GoRouterState state,
  );

  /// Priority for middleware execution (lower = executed first)
  /// Default is 100
  int get priority => 100;

  /// Name of the middleware for logging/debugging
  String get name => runtimeType.toString();
}

/// Middleware context with additional information
class MiddlewareContext {
  final BuildContext buildContext;
  final GoRouterState routerState;
  final Map<String, dynamic> data;

  MiddlewareContext({
    required this.buildContext,
    required this.routerState,
    this.data = const {},
  });

  /// Current route path
  String get path => routerState.matchedLocation;

  /// Query parameters
  Map<String, String> get queryParams => routerState.uri.queryParameters;

  /// Path parameters
  Map<String, String> get pathParams => routerState.pathParameters;

  /// Check if route is public (doesn't require auth)
  bool get isPublicRoute =>
      path.startsWith('/login') ||
      path.startsWith('/splash') ||
      path.startsWith('/register');

  /// Check if route is private (requires auth)
  bool get isPrivateRoute => !isPublicRoute;
}

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:project_architecture/core/manager/routing/middleware/middleware_manager.dart';
import 'package:project_architecture/routes/routes.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

/// Router with middleware support
final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routes: $appRoutes,
  navigatorKey: _navigatorKey,
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) async {
    // Execute middleware chain
    final middlewareManager = MiddlewareManager();
    final middlewareResult = await middlewareManager.execute(context, state);

    // If middleware returned a redirect, use it
    if (middlewareResult != null) {
      return middlewareResult;
    }

    // Default redirect for root
    // if (state.matchedLocation == '/') {
    //   return SplashViewRoute().location;
    // }

    return null;
  },
);

/// Navigation helper class with safe context access
class Navigate {
  /// Get current navigator context
  ///
  /// Throws an exception if context is null (app not yet initialized)
  static BuildContext get currentContext {
    final context = _navigatorKey.currentContext;
    if (context == null) {
      throw Exception(
        'Navigator context is null. '
        'Ensure the app is properly initialized and MaterialApp.router is mounted.',
      );
    }
    return context;
  }

  /// Navigate back in the navigation stack
  ///
  /// Throws an exception if context is null
  static void back() {
    final context = _navigatorKey.currentContext;
    if (context == null) {
      throw Exception(
        'Cannot navigate back: Navigator context is null. '
        'Ensure the app is properly initialized.',
      );
    }
    context.pop();
  }
}

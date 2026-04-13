import 'package:project_architecture/core/manager/routing/middleware/analytics_middleware.dart';
import 'package:project_architecture/core/manager/routing/middleware/auth_middleware.dart';
import 'package:project_architecture/core/manager/routing/middleware/logging_middleware.dart';
import 'package:project_architecture/core/manager/routing/middleware/middleware_manager.dart';
import 'package:project_architecture/core/manager/storage/storage_manager.dart';
import 'package:project_architecture/injection_container.dart' show sl;

/// Setup and register all navigation middleware
///
/// Call this once during app initialization
void setupNavigationMiddleware() {
  final middlewareManager = MiddlewareManager();

  // Clear any existing middleware
  middlewareManager.clear();

  // Register middleware in order of priority:
  // 1. AuthMiddleware (priority: 10) - Check authentication first
  // 2. LoggingMiddleware (priority: 50) - Log navigation events
  // 3. AnalyticsMiddleware (priority: 90) - Track analytics last

  // 1. Authentication Middleware
  middlewareManager.register(
    AuthMiddleware(
      storage: sl<StorageManager>(),
      loginRoute: '/login',
      publicRoutes: [
        '/login',
        '/splash',
        '/register',
        '/forgot-password',
      ],
    ),
  );

  // 2. Logging Middleware (only in debug mode, managed internally)
  middlewareManager.register(
    const LoggingMiddleware(verbose: true),
  );

  // 3. Analytics Middleware
  middlewareManager.register(
    const AnalyticsMiddleware(
      enabled: true,
      excludedRoutes: ['/splash'], // Don't track splash screen
    ),
  );

  // Mark as initialized
  middlewareManager.setInitialized();

  // Print middleware chain
  middlewareManager.printChain();
}

/// Example: Custom middleware implementation
///
/// You can create custom middleware by extending NavigationMiddleware:
///
/// ```dart
/// class CustomMiddleware extends NavigationMiddleware {
///   @override
///   Future<MiddlewareResult> execute(
///     BuildContext context,
///     GoRouterState state,
///   ) async {
///     // Your custom logic here
///     return const MiddlewareResult.proceed();
///   }
///
///   @override
///   int get priority => 80;
///
///   @override
///   String get name => 'CustomMiddleware';
/// }
///
/// // Register it:
/// MiddlewareManager().register(CustomMiddleware());
/// ```

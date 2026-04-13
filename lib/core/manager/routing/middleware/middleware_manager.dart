import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:project_architecture/core/manager/routing/middleware/navigation_middleware.dart';

/// Middleware Manager
///
/// Manages and executes navigation middleware in order of priority
class MiddlewareManager {
  MiddlewareManager._internal();
  static final MiddlewareManager _instance = MiddlewareManager._internal();
  factory MiddlewareManager() => _instance;

  final List<NavigationMiddleware> _middleware = [];
  bool _isInitialized = false;

  /// Register a middleware
  void register(NavigationMiddleware middleware) {
    _middleware.add(middleware);
    _sortMiddleware();
    debugPrint('✅ Middleware registered: ${middleware.name} (priority: ${middleware.priority})');
  }

  /// Register multiple middleware
  void registerAll(List<NavigationMiddleware> middlewares) {
    _middleware.addAll(middlewares);
    _sortMiddleware();
    debugPrint('✅ ${middlewares.length} middleware registered');
  }

  /// Clear all middleware
  void clear() {
    _middleware.clear();
    _isInitialized = false;
    debugPrint('🗑️ All middleware cleared');
  }

  /// Get all registered middleware
  List<NavigationMiddleware> get all => List.unmodifiable(_middleware);

  /// Get middleware count
  int get count => _middleware.length;

  /// Check if initialized
  bool get isInitialized => _isInitialized;

  /// Mark as initialized
  void setInitialized() {
    _isInitialized = true;
  }

  /// Execute all middleware in order
  ///
  /// Returns the redirect path if any middleware requests a redirect,
  /// otherwise returns null to proceed with navigation
  Future<String?> execute(
    BuildContext context,
    GoRouterState state,
  ) async {
    if (_middleware.isEmpty) {
      return null; // No middleware, proceed
    }

    try {
      // Execute each middleware in priority order
      for (final middleware in _middleware) {
        final result = await middleware.execute(context, state);

        // Check if middleware wants to redirect or block
        if (!result.canProceed) {
          if (result.redirectTo != null) {
            debugPrint('🔀 Middleware ${middleware.name} redirecting to: ${result.redirectTo}');
            return result.redirectTo;
          } else {
            debugPrint('🚫 Middleware ${middleware.name} blocked navigation');
            return state.matchedLocation; // Stay on current route
          }
        }
      }

      // All middleware passed
      return null;
    } catch (e, stack) {
      debugPrint('❌ Middleware execution error: $e');
      debugPrint('Stack trace: $stack');
      // On error, allow navigation to proceed (fail-open)
      return null;
    }
  }

  /// Sort middleware by priority (lower priority = execute first)
  void _sortMiddleware() {
    _middleware.sort((a, b) => a.priority.compareTo(b.priority));
  }

  /// Print middleware chain for debugging
  void printChain() {
    if (_middleware.isEmpty) {
      debugPrint('📋 No middleware registered');
      return;
    }

    debugPrint('📋 Middleware Chain (${_middleware.length} middleware):');
    for (var i = 0; i < _middleware.length; i++) {
      final m = _middleware[i];
      debugPrint('   ${i + 1}. ${m.name} (priority: ${m.priority})');
    }
  }

  /// Remove a specific middleware by type
  void remove<T extends NavigationMiddleware>() {
    _middleware.removeWhere((m) => m is T);
    debugPrint('🗑️ Middleware removed: $T');
  }

  /// Check if specific middleware is registered
  bool has<T extends NavigationMiddleware>() {
    return _middleware.any((m) => m is T);
  }

  /// Get specific middleware instance
  T? get<T extends NavigationMiddleware>() {
    try {
      return _middleware.firstWhere((m) => m is T) as T;
    } catch (e) {
      return null;
    }
  }
}

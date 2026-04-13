import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:project_architecture/core/manager/routing/middleware/navigation_middleware.dart';

/// Logging middleware
///
/// Logs all navigation events for debugging and monitoring
class LoggingMiddleware extends NavigationMiddleware {
  final bool verbose;

  const LoggingMiddleware({this.verbose = true});

  @override
  Future<MiddlewareResult> execute(
    BuildContext context,
    GoRouterState state,
  ) async {
    if (!kDebugMode) {
      return const MiddlewareResult.proceed();
    }

    final path = state.matchedLocation;
    final queryParams = state.uri.queryParameters;
    final pathParams = state.pathParameters;

    debugPrint('┌──────────────────────────────────────────');
    debugPrint('│ 🧭 Navigation Event');
    debugPrint('├──────────────────────────────────────────');
    debugPrint('│ Path: $path');

    if (queryParams.isNotEmpty) {
      debugPrint('│ Query Params: $queryParams');
    }

    if (pathParams.isNotEmpty) {
      debugPrint('│ Path Params: $pathParams');
    }

    if (verbose && state.extra != null) {
      debugPrint('│ Extra Data: ${state.extra}');
    }

    debugPrint('│ Timestamp: ${DateTime.now().toIso8601String()}');
    debugPrint('└──────────────────────────────────────────');

    return const MiddlewareResult.proceed();
  }

  @override
  int get priority => 50; // Execute in middle

  @override
  String get name => 'LoggingMiddleware';
}

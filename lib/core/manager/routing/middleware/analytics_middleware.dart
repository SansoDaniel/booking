import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:booking_app/core/manager/routing/middleware/navigation_middleware.dart';

/// Analytics middleware
///
/// Tracks navigation events for analytics (Firebase, Mixpanel, etc.)
class AnalyticsMiddleware extends NavigationMiddleware {
  final bool enabled;
  final List<String> excludedRoutes;

  const AnalyticsMiddleware({
    this.enabled = true,
    this.excludedRoutes = const [],
  });

  @override
  Future<MiddlewareResult> execute(
    BuildContext context,
    GoRouterState state,
  ) async {
    if (!enabled) {
      return const MiddlewareResult.proceed();
    }

    final path = state.matchedLocation;

    // Skip excluded routes
    if (_isExcluded(path)) {
      return const MiddlewareResult.proceed();
    }

    // Track screen view
    await _trackScreenView(path, state);

    return const MiddlewareResult.proceed();
  }

  /// Track screen view in analytics
  Future<void> _trackScreenView(String path, GoRouterState state) async {
    try {
      // TODO: Implement actual analytics tracking
      // Examples:
      // - FirebaseAnalytics: analytics.logScreenView(screenName: path)
      // - Mixpanel: mixpanel.track('Screen View', properties: {...})
      // - Custom analytics service

      final params = <String, dynamic>{
        'screen_name': _extractScreenName(path),
        'screen_path': path,
        'timestamp': DateTime.now().toIso8601String(),
      };

      // Add query params if present
      if (state.uri.queryParameters.isNotEmpty) {
        params['query_params'] = state.uri.queryParameters;
      }

      // Log for now (replace with actual analytics)
      debugPrint('📊 Analytics: Screen View - ${params['screen_name']}');

      // Uncomment when Firebase Analytics is configured:
      // await FirebaseAnalytics.instance.logScreenView(
      //   screenName: params['screen_name'],
      //   screenClass: path,
      // );
    } catch (e) {
      debugPrint('⚠️ Analytics tracking error: $e');
    }
  }

  /// Extract screen name from path
  String _extractScreenName(String path) {
    // Remove leading slash and convert to readable name
    final cleanPath = path.replaceAll('/', ' ').trim();
    if (cleanPath.isEmpty) return 'Home';

    // Convert to title case
    return cleanPath
        .split(' ')
        .map((word) => word.isEmpty
            ? ''
            : '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  /// Check if route should be excluded from analytics
  bool _isExcluded(String path) {
    return excludedRoutes.any((route) => path.startsWith(route));
  }

  @override
  int get priority => 90; // Execute late (after auth/logging)

  @override
  String get name => 'AnalyticsMiddleware';
}

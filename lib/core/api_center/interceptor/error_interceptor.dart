import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:booking_app/core/api_center/api_error.dart';

/// Interceptor for handling and transforming API errors
///
/// Converts DioException into ApiError for consistent error handling
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final apiError = ApiError.fromDioException(err);

    // Log error details (only in debug mode)
    _logError(err, apiError);

    // Pass the error along with additional context
    handler.next(err);
  }

  void _logError(DioException err, ApiError apiError) {
    if (!kDebugMode) return;

    debugPrint('╔════════════════════════════════════════════════════════════════');
    debugPrint('║ API ERROR');
    debugPrint('╠════════════════════════════════════════════════════════════════');
    debugPrint('║ URL: ${err.requestOptions.uri}');
    debugPrint('║ Method: ${err.requestOptions.method}');
    debugPrint('║ Status Code: ${apiError.statusCode ?? 'N/A'}');
    debugPrint('║ Type: ${apiError.type}');
    debugPrint('║ Message: ${apiError.message}');
    if (apiError.data != null) {
      debugPrint('║ Response Data: ${apiError.data}');
    }
    if (err.stackTrace != null) {
      debugPrint('║ Stack Trace:\n${err.stackTrace}');
    }
    debugPrint('╚════════════════════════════════════════════════════════════════');
  }
}

import 'package:dio/dio.dart';

/// Custom API error class for better error handling
class ApiError implements Exception {
  final String message;
  final int? statusCode;
  final DioExceptionType? type;
  final dynamic data;

  ApiError({
    required this.message,
    this.statusCode,
    this.type,
    this.data,
  });

  factory ApiError.fromDioException(DioException exception) {
    String message;
    int? statusCode = exception.response?.statusCode;

    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timeout. Please check your internet connection.';
        break;

      case DioExceptionType.badResponse:
        message = _handleBadResponse(exception.response);
        break;

      case DioExceptionType.cancel:
        message = 'Request cancelled.';
        break;

      case DioExceptionType.connectionError:
        message = 'No internet connection. Please check your network.';
        break;

      case DioExceptionType.badCertificate:
        message = 'Certificate verification failed.';
        break;

      case DioExceptionType.unknown:
      default:
        message = 'An unexpected error occurred. Please try again.';
        break;
    }

    return ApiError(
      message: message,
      statusCode: statusCode,
      type: exception.type,
      data: exception.response?.data,
    );
  }

  static String _handleBadResponse(Response? response) {
    if (response == null) return 'Server error occurred.';

    final statusCode = response.statusCode;
    final data = response.data;

    // Try to extract error message from response
    String? errorMessage;
    if (data is Map<String, dynamic>) {
      errorMessage = data['message'] as String? ??
          data['error'] as String? ??
          data['errors']?[0] as String?;
    }

    // Fallback to status code messages
    switch (statusCode) {
      case 400:
        return errorMessage ?? 'Bad request. Please check your input.';
      case 401:
        return errorMessage ?? 'Unauthorized. Please login again.';
      case 403:
        return errorMessage ?? 'Access forbidden.';
      case 404:
        return errorMessage ?? 'Resource not found.';
      case 422:
        return errorMessage ?? 'Validation error. Please check your input.';
      case 500:
        return errorMessage ?? 'Server error. Please try again later.';
      case 503:
        return errorMessage ?? 'Service unavailable. Please try again later.';
      default:
        return errorMessage ?? 'An error occurred (Code: $statusCode).';
    }
  }

  @override
  String toString() => message;

  /// Check if error is due to network issues
  bool get isNetworkError =>
      type == DioExceptionType.connectionTimeout ||
      type == DioExceptionType.sendTimeout ||
      type == DioExceptionType.receiveTimeout ||
      type == DioExceptionType.connectionError;

  /// Check if error is due to authentication
  bool get isAuthError => statusCode == 401 || statusCode == 403;

  /// Check if error is due to validation
  bool get isValidationError => statusCode == 422 || statusCode == 400;

  /// Check if error is server-side
  bool get isServerError => statusCode != null && statusCode! >= 500;
}

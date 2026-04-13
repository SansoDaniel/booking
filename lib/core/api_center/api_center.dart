import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:booking_app/core/api_center/interceptor/error_interceptor.dart';
import 'package:booking_app/core/api_center/interceptor/loader_interceptor.dart';
import 'package:booking_app/core/api_center/interceptor/mock_interceptor.dart';
import 'package:booking_app/core/api_center/interceptor/token_interceptor.dart';
import 'package:booking_app/core/manager/environment/environment_manager.dart';

enum ApiConstantKey {
  showLoaderKey('showLoader');

  final String value;
  const ApiConstantKey(this.value);
}

extension DioNoLoader on Dio {
  Dio get noLoader =>
      this..options.extra[ApiConstantKey.showLoaderKey.value] = false;
}

/// Central API configuration and management class
///
/// Provides a singleton Dio instance with configured interceptors for:
/// - Request/response logging
/// - Loading indicator management
/// - Authentication token injection
/// - Mock data in development
class ApiCenter {
  ApiCenter._internal() {
    _initializeDio();
  }

  static final ApiCenter _instance = ApiCenter._internal();
  factory ApiCenter() => _instance;

  late final Dio _dio;
  final LoaderInterceptor _loaderInterceptor = LoaderInterceptor();

  /// Public access to the configured Dio instance
  Dio get dio => _dio;

  /// Get the loader interceptor instance for external control
  LoaderInterceptor get loaderInterceptor => _loaderInterceptor;

  void _initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvironmentManager.apiUrl,
        extra: <String, dynamic>{ApiConstantKey.showLoaderKey.value: true},
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        persistentConnection: true,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _addInterceptors();
  }

  void _addInterceptors() {
    // Add interceptors in order of execution

    // 1. Mock interceptor (only in mock environment)
    if (EnvironmentManager.environment == 'mock') {
      _dio.interceptors.add(const MockInterceptor());
    }

    // 2. Loader interceptor
    _dio.interceptors.add(_loaderInterceptor);

    // 3. Error interceptor for consistent error handling
    _dio.interceptors.add(ErrorInterceptor());

    // 4. Logging interceptor (only in debug mode)
    if (EnvironmentManager.environment == 'dev' ||
        EnvironmentManager.environment == 'development') {
      _dio.interceptors.add(
        LogInterceptor(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          logPrint: (Object object) {
            // Use debugPrint instead of print for better Flutter integration
            debugPrint('[API] $object');
          },
        ),
      );
    }
  }

  /// Add or update authentication token
  ///
  /// This will add a TokenInterceptor if not present, or update the existing one
  void setAccessToken(String token) {
    // Remove existing token interceptor if present
    _dio.interceptors.removeWhere(
      (interceptor) => interceptor is TokenInterceptor,
    );

    // Add new token interceptor
    _dio.interceptors.add(TokenInterceptor(token));
  }

  /// Remove authentication token
  void clearAccessToken() {
    _dio.interceptors.removeWhere(
      (interceptor) => interceptor is TokenInterceptor,
    );
  }

  /// Check if access token is set
  bool get hasAccessToken {
    return _dio.interceptors.any(
      (interceptor) => interceptor is TokenInterceptor,
    );
  }

  /// Reset all interceptors and reinitialize
  void reset() {
    _dio.interceptors.clear();
    _addInterceptors();
  }
}

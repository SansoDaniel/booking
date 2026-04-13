import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:project_architecture/core/manager/environment/environment_manager.dart';

/// Interceptor for returning mock responses from JSON files
///
/// When environment is set to 'mock', this interceptor will:
/// 1. Intercept all API requests
/// 2. Load corresponding JSON file from development/mock/
/// 3. Return the mock response without making actual HTTP call
///
/// File naming convention: {METHOD}_{path}.json
/// Example: GET_users.json, POST_login.json
class MockInterceptor extends Interceptor {
  const MockInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (EnvironmentManager.environment == 'mock') {
      try {
        // Clean the path: remove leading slash and replace slashes with underscores
        final cleanPath = options.path.replaceAll('/', '_').replaceFirst('_', '');
        final fileName = '${options.method}_$cleanPath.json';

        final json = await rootBundle.loadString(
          'development/mock/$fileName',
        );

        return handler.resolve(
          Response<Object>(
            requestOptions: options,
            statusCode: 200,
            data: jsonDecode(json),
          ),
        );
      } catch (error) {
        return handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            error: error,
            message:
                'Mock file not found for ${options.method} ${options.path}.\n'
                'Create file: development/mock/${options.method}_${options.path.replaceAll('/', '_')}.json',
          ),
        );
      }
    }
    return super.onRequest(options, handler);
  }
}

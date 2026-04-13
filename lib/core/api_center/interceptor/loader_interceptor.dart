import 'package:dio/dio.dart';
import 'package:project_architecture/core/manager/ui/loading_manager.dart';

/// Interceptor that manages loading indicators for API requests
///
/// Shows a loading indicator when a request starts and hides it when complete
/// Only shows loader for requests that have showLoader: true in extra options
class LoaderInterceptor extends Interceptor {
  LoaderInterceptor();

  final LoadingManager _loadingManager = LoadingManager();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra['showLoader'] == true) {
      _loadingManager.showLoading();
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.requestOptions.extra['showLoader'] == true) {
      _loadingManager.hideLoading();
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.requestOptions.extra['showLoader'] == true) {
      _loadingManager.hideLoading();
    }
    super.onError(err, handler);
  }
}

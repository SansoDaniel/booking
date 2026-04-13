import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  final String accessToken;

  TokenInterceptor(this.accessToken);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $accessToken';
    super.onRequest(options, handler);
  }
}

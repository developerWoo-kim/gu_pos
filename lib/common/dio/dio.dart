import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  // final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    CustomInterceptor(
        ref:  ref
    ),
  );

  return dio;
});

class CustomInterceptor extends Interceptor {
  final Ref ref;

  CustomInterceptor({
    required this.ref,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('[REQ] [${options.method}] ${options.uri}');
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('[ERROR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

  }
}
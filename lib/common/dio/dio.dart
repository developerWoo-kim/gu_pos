import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  // final storage = ref.watch(secureStorageProvider);
  //
  // dio.interceptors.add(
  //   CustomInterceptor(
  //       storage: storage,
  //       ref:  ref
  //   ),
  // );

  return dio;
});
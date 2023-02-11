import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rest_client.g.dart';

@Riverpod(keepAlive: true)
Dio restClient(RestClientRef ref) {
  return Dio();
}

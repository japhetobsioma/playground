import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CancelTokenNotifier extends Notifier<CancelToken> {
  @override
  CancelToken build() => CancelToken();
}

final cancelTokenProvider = NotifierProvider<CancelTokenNotifier, CancelToken>(
  CancelTokenNotifier.new,
);

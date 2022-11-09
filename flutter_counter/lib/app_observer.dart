import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppObserver extends ProviderObserver {
  const AppObserver();

  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      print(
        '${provider.name ?? provider.runtimeType} '
        '(previousValue: $previousValue, newValue: $newValue)',
      );
    }
  }
}

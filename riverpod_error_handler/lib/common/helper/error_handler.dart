import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorHandler<T> extends ConsumerWidget {
  const ErrorHandler({
    required this.provider,
    required this.child,
    super.key,
  });

  final ProviderListenable<T> provider;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      provider,
      (previous, next) {
        if (next is AsyncError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );

    return child;
  }
}

import 'package:flutter_counter/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('CounterProvider', () {
    test('initial state is 0', () {
      // Arrange
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Assert
      final state = container.read(counterProvider);
      expect(state, 0);
    });

    group('increment()', () {
      test('adds 1 to the current state', () {
        // Arrange
        final container = ProviderContainer();
        addTearDown(container.dispose);

        // Act
        container.read(counterProvider.notifier).increment();

        // Assert
        final state = container.read(counterProvider);
        expect(state, 1);
      });
    });

    group('decrement()', () {
      test('deducts 1 to the current state', () {
        // Arrange
        final container = ProviderContainer();
        addTearDown(container.dispose);

        // Act
        container.read(counterProvider.notifier).decrement();

        // Assert
        final state = container.read(counterProvider);
        expect(state, -1);
      });
    });
  });
}

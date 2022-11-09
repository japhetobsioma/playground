import 'package:flutter/material.dart';
import 'package:flutter_counter/app.dart';
import 'package:flutter_counter/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class MockCounterNotifier extends Notifier<int>
    with Mock
    implements CounterNotifier {
  @override
  int build() => 0;
}

void main() {
  group('CounterPage', () {
    testWidgets('renders current state', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(child: App()),
      );

      // Assert
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('tapping increment button invokes increment', (tester) async {
      // Arrange
      final counterNotifier = MockCounterNotifier();
      when(counterNotifier.increment).thenReturn(null);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [counterProvider.overrideWith(() => counterNotifier)],
          child: const App(),
        ),
      );

      // Acct
      await tester.tap(
        find.byKey(const Key('counterPage_increment_floatingActionButton')),
      );

      // Assert
      verify(counterNotifier.increment).called(1);
    });

    testWidgets('tapping decrement button invokes decrement', (tester) async {
      // Arrange
      final counterNotifier = MockCounterNotifier();
      when(counterNotifier.decrement).thenReturn(null);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [counterProvider.overrideWith(() => counterNotifier)],
          child: const App(),
        ),
      );

      // Acct
      final decrementFinder = find.byKey(
        const Key('counterPage_decrement_floatingActionButton'),
      );
      await tester.ensureVisible(decrementFinder);
      await tester.tap(decrementFinder);

      // Assert
      verify(counterNotifier.decrement).called(1);
    });
  });
}

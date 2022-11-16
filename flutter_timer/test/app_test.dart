import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_timer/app.dart';
import 'package:flutter_timer/timer/timer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('App', () {
    testWidgets('renders TimerPage', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));

      expect(find.byType(TimerPage), findsOneWidget);
    });
  });
}

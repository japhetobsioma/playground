import 'package:flutter/material.dart';
import 'package:flutter_weather/feature/settings/settings.dart';
import 'package:flutter_weather/feature/weather/provider/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ProviderScope(
          overrides: [
            weatherProvider.overrideWith((ref) {
              return WeatherNotifier()..fetchWeather('TESTING');
            })
          ],
          child: const _Weather(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          ref.invalidate(weatherProvider);
        },
      ),
    );
  }
}

class _Weather extends ConsumerWidget {
  const _Weather();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(weatherProvider);
    ref.listen(weatherProvider, (previous, next) {
      print('previous: $previous, next: $next');
    });

    return state.when(
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      data: (data) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(data.condition.name),
            Text(data.lastUpdated.toString()),
            Text(data.location),
            Text(data.temperature.toString()),
            Text(data.temperatureUnits.name),
          ],
        );
      },
      error: (error, stackTrace) => Text('Error: $error'),
      loading: CircularProgressIndicator.new,
    );
  }
}

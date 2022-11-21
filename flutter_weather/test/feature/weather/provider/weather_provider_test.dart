// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/common/enum/enum.dart';
import 'package:flutter_weather/feature/weather/weather.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_meteo_api/open_meteo_api.dart';

class MockRepository extends Mock implements WeatherRepository {}

void main() {
  group('WeatherProvider', () {
    test('initial state is correct', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(weatherProvider);
      expect(state, AsyncLoading<WeatherState>());
    });

    test('supports overriding state', () {
      final mockState = AsyncData(
        WeatherState(
          condition: WeatherCondition.clear,
          lastUpdated: DateTime(0),
          location: 'chicago',
          temperature: 420,
          temperatureUnits: TemperatureUnits.celsius,
        ),
      );
      final container = ProviderContainer(
        overrides: [
          weatherProvider.overrideWith((ref) {
            return WeatherNotifier(state: mockState);
          })
        ],
      );
      addTearDown(container.dispose);

      final state = container.read(weatherProvider);
      expect(state, mockState);
    });

    test('supports overriding repository', () {
      final repository = MockRepository();
      final container = ProviderContainer(
        overrides: [
          weatherProvider.overrideWith((ref) {
            return WeatherNotifier(repository: repository)..fetchWeather('');
          })
        ],
      );
      addTearDown(container.dispose);

      container.read(weatherProvider);

      verify(() => repository.locationSearch(any())).called(1);
    });

    group('fetchWeather', () {
      test('calls locationSearch', () async {
        final repository = MockRepository();

        final container = ProviderContainer(
          overrides: [
            weatherProvider.overrideWith((ref) {
              return WeatherNotifier(repository: repository);
            })
          ],
        );
        addTearDown(container.dispose);

        await container.read(weatherProvider.notifier).fetchWeather('');

        verify(
          () => repository.locationSearch(any()),
        ).called(1);
      });

      test('handles exception when locationSearch throws', () async {
        final repository = MockRepository();
        final exception = Exception('oops');
        when(() => repository.locationSearch(any())).thenThrow(exception);

        final container = ProviderContainer(
          overrides: [
            weatherProvider.overrideWith((ref) {
              return WeatherNotifier(repository: repository);
            })
          ],
        );
        addTearDown(container.dispose);

        await container.read(weatherProvider.notifier).fetchWeather('');
        final state = container.read(weatherProvider);

        expect(
          state,
          isA<AsyncError<WeatherState>>().having(
            (a) => a.error,
            'error',
            exception,
          ),
        );
      });

      test('calls getWeather', () async {
        final repository = MockRepository();
        when(() => repository.locationSearch(any())).thenAnswer(
          (_) async => Location(
            id: 123,
            name: 'chicago',
            latitude: 420,
            longitude: 100,
          ),
        );

        final container = ProviderContainer(
          overrides: [
            weatherProvider.overrideWith((ref) {
              return WeatherNotifier(repository: repository);
            })
          ],
        );
        addTearDown(container.dispose);

        await container.read(weatherProvider.notifier).fetchWeather('');

        verify(
          () => repository.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).called(1);
      });

      test('handles exception when getWeather throws', () async {
        final repository = MockRepository();
        final exception = Exception('oops');
        when(() => repository.locationSearch(any())).thenAnswer(
          (_) async => Location(
            id: 123,
            name: 'chicago',
            latitude: 420,
            longitude: 100,
          ),
        );
        when(
          () => repository.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenThrow(exception);

        final container = ProviderContainer(
          overrides: [
            weatherProvider.overrideWith((ref) {
              return WeatherNotifier(repository: repository);
            })
          ],
        );
        addTearDown(container.dispose);

        final states = <AsyncValue<WeatherState>>[];

        container.listen(
          weatherProvider,
          fireImmediately: true,
          (previous, next) => states.add(next),
        );

        await container.read(weatherProvider.notifier).fetchWeather('');
        await container.pump();

        expect(
          states.last,
          isA<AsyncError<WeatherState>>().having(
            (a) => a.error,
            'error',
            exception,
          ),
        );
      });

      test('updates correct state', () async {
        final repository = MockRepository();
        when(() => repository.locationSearch(any())).thenAnswer(
          (_) async => Location(
            id: 123,
            name: 'chicago',
            latitude: 420,
            longitude: 100,
          ),
        );
        when(
          () => repository.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => Weather(temperature: 42, weatherCode: 123));

        final container = ProviderContainer(
          overrides: [
            weatherProvider.overrideWith((ref) {
              return WeatherNotifier(repository: repository);
            })
          ],
        );
        addTearDown(container.dispose);

        final states = <AsyncValue<WeatherState>>[];

        container.listen(
          weatherProvider,
          fireImmediately: true,
          (previous, next) {
            if (states.isEmpty && previous != null) states.add(previous);
            states.add(next);
          },
        );

        await container.read(weatherProvider.notifier).fetchWeather('');
        await container.pump();

        expect(
          states.last,
          isA<AsyncData<WeatherState>>(),
        );
      });
    });

    group('toggleUnits', () {
      test('updates correct temperatureUnits', () {
        final mockState = AsyncData(
          WeatherState(
            condition: WeatherCondition.clear,
            lastUpdated: DateTime(0),
            location: 'chicago',
            temperature: 42,
            temperatureUnits: TemperatureUnits.celsius,
          ),
        );
        final container = ProviderContainer(
          overrides: [
            weatherProvider.overrideWith((ref) {
              return WeatherNotifier(state: mockState);
            })
          ],
        );
        addTearDown(container.dispose);

        container.read(weatherProvider.notifier).toggleUnits();
        final state = container.read(weatherProvider);

        expect(
          state.requireValue.temperatureUnits,
          TemperatureUnits.fahrenheit,
        );

        container.read(weatherProvider.notifier).toggleUnits();
        final newState = container.read(weatherProvider);

        expect(
          newState.requireValue.temperatureUnits,
          TemperatureUnits.celsius,
        );
      });

      test('updates correct temperature', () {
        final mockState = AsyncData(
          WeatherState(
            condition: WeatherCondition.clear,
            lastUpdated: DateTime(0),
            location: 'chicago',
            temperature: 42,
            temperatureUnits: TemperatureUnits.celsius,
          ),
        );
        final container = ProviderContainer(
          overrides: [
            weatherProvider.overrideWith((ref) {
              return WeatherNotifier(state: mockState);
            })
          ],
        );
        addTearDown(container.dispose);

        container.read(weatherProvider.notifier).toggleUnits();
        final state = container.read(weatherProvider);

        expect(state.requireValue.temperature, 107.6);

        container.read(weatherProvider.notifier).toggleUnits();
        final newState = container.read(weatherProvider);

        expect(newState.requireValue.temperature, 42);
      });
    });
  });
}

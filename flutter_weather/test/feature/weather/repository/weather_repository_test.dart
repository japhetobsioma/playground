// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/feature/weather/weather.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_meteo_api/open_meteo_api.dart';

class MockApiClient extends Mock implements OpenMeteoApiClient {}

class MockLocation extends Mock implements Location {}

class MockWeather extends Mock implements Weather {}

void main() {
  group('WeatherRepository', () {
    late OpenMeteoApiClient apiClient;
    late WeatherRepository repository;

    setUp(() {
      apiClient = MockApiClient();
      repository = WeatherRepository(apiClient: apiClient);
    });

    group('constructor', () {
      test('instantiates internal weather api client when not injected', () {
        expect(WeatherRepository(), isNotNull);
      });
    });

    group('locationSearch', () {
      const query = 'mock-query';

      test('call locationSearch with correct query', () async {
        try {
          await repository.locationSearch(query);
        } catch (_) {}
        verify(() => apiClient.locationSearch(query)).called(1);
      });

      test('throws when locationSearch fails', () async {
        final exception = Exception('oops');

        when(
          () => apiClient.locationSearch(query),
        ).thenThrow(exception);

        await expectLater(repository.locationSearch(query), throwsA(exception));
      });

      test('returns correct location on success', () async {
        final location = MockLocation();

        when(() => location.id).thenReturn(1);
        when(() => location.name).thenReturn('chicago');
        when(() => location.latitude).thenReturn(42.42);
        when(() => location.longitude).thenReturn(100.05);
        when(
          () => apiClient.locationSearch(query),
        ).thenAnswer((_) async => location);

        final actual = await repository.locationSearch(query);

        expect(
          actual,
          Location(
            id: 1,
            name: 'chicago',
            latitude: 42.42,
            longitude: 100.05,
          ),
        );
      });
    });

    group('getWeather', () {
      const latitude = 41.85003;
      const longitude = -87.65005;

      test('call getWeather with correct latitude/longitude', () async {
        try {
          await repository.getWeather(
            latitude: latitude,
            longitude: longitude,
          );
        } catch (_) {}

        verify(
          () => apiClient.getWeather(latitude: latitude, longitude: longitude),
        ).called(1);
      });

      test('throws when getWeather fails', () async {
        final exception = Exception('oops');

        when(
          () => apiClient.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenThrow(exception);

        await expectLater(
          repository.getWeather(latitude: latitude, longitude: longitude),
          throwsA(exception),
        );
      });

      test('returns correct weather on success', () async {
        final weather = MockWeather();

        when(() => weather.temperature).thenReturn(42.42);
        when(() => weather.weatherCode).thenReturn(1);
        when(
          () => apiClient.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => weather);

        final actual = await repository.getWeather(
          latitude: latitude,
          longitude: longitude,
        );

        expect(actual, Weather(temperature: 42.42, weatherCode: 1));
      });
    });
  });
}

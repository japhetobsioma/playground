// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_meteo_api/open_meteo_api.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements Dio {}

class MockResponse extends Mock implements Response<Map<String, dynamic>> {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('OpenMeteoApiClient', () {
    late Dio httpClient;
    late OpenMeteoApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = OpenMeteoApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(OpenMeteoApiClient(), isNotNull);
      });
    });

    group('locationSearch', () {
      const query = 'mock-query';

      test('makes correct http request', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn({});
        when(
          () => httpClient.getUri<Map<String, dynamic>>(any()),
        ).thenAnswer((_) async => response);

        try {
          await apiClient.locationSearch(query);
        } catch (_) {}

        verify(
          () => httpClient.getUri<Map<String, dynamic>>(
            Uri.https(
              'geocoding-api.open-meteo.com',
              '/v1/search',
              {'name': query, 'count': '1'},
            ),
          ),
        ).called(1);
      });

      test('throws LocationRequestFailure on non-200 response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(400);
        when(
          () => httpClient.getUri<Map<String, dynamic>>(any()),
        ).thenAnswer((_) async => response);

        await expectLater(
          apiClient.locationSearch(query),
          throwsA(isA<LocationRequestFailure>()),
        );
      });

      test('throws LocationNotFoundFailure on error response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn({});
        when(
          () => httpClient.getUri<Map<String, dynamic>>(any()),
        ).thenAnswer((_) async => response);

        await expectLater(
          apiClient.locationSearch(query),
          throwsA(isA<LocationNotFoundFailure>()),
        );
      });

      test('throws LocationNotFoundFailure on empty response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn({'results': <dynamic>[]});
        when(
          () => httpClient.getUri<Map<String, dynamic>>(any()),
        ).thenAnswer((_) async => response);

        await expectLater(
          apiClient.locationSearch(query),
          throwsA(isA<LocationNotFoundFailure>()),
        );
      });

      test('returns Location on valid response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn({
          'results': [
            {
              'id': 4887398,
              'name': 'Chicago',
              'latitude': 41.85003,
              'longitude': -87.65005
            }
          ]
        });
        when(
          () => httpClient.getUri<Map<String, dynamic>>(any()),
        ).thenAnswer((_) async => response);

        final actual = await apiClient.locationSearch(query);

        expect(
          actual,
          isA<Location>()
              .having((l) => l.name, 'name', 'Chicago')
              .having((l) => l.id, 'id', 4887398)
              .having((l) => l.latitude, 'latitude', 41.85003)
              .having((l) => l.longitude, 'longitude', -87.65005),
        );
      });
    });

    group('getWeather', () {
      const latitude = 41.85003;
      const longitude = -87.6500;

      test('makes correct http request', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn({});
        when(
          () => httpClient.getUri<Map<String, dynamic>>(any()),
        ).thenAnswer((_) async => response);

        try {
          await apiClient.getWeather(latitude: latitude, longitude: longitude);
        } catch (_) {}

        verify(
          () => httpClient.getUri<Map<String, dynamic>>(
            Uri.https('api.open-meteo.com', 'v1/forecast', {
              'latitude': '$latitude',
              'longitude': '$longitude',
              'current_weather': 'true'
            }),
          ),
        ).called(1);
      });

      test('throws WeatherRequestFailure on non-200 response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(400);
        when(
          () => httpClient.getUri<Map<String, dynamic>>(any()),
        ).thenAnswer((_) async => response);

        await expectLater(
          apiClient.getWeather(latitude: latitude, longitude: longitude),
          throwsA(isA<WeatherRequestFailure>()),
        );
      });

      test('throws WeatherNotFoundFailure on empty response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn({});
        when(
          () => httpClient.getUri<Map<String, dynamic>>(any()),
        ).thenAnswer((_) async => response);

        await expectLater(
          apiClient.getWeather(latitude: latitude, longitude: longitude),
          throwsA(isA<WeatherNotFoundFailure>()),
        );
      });

      test('returns weather on valid response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn({
          'latitude': 43,
          'longitude': -87.875,
          'generationtime_ms': 0.2510547637939453,
          'utc_offset_seconds': 0,
          'timezone': 'GMT',
          'timezone_abbreviation': 'GMT',
          'elevation': 189,
          'current_weather': {
            'temperature': 15.3,
            'windspeed': 25.8,
            'winddirection': 310,
            'weathercode': 63,
            'time': '2022-09-12T01:00'
          }
        });

        when(
          () => httpClient.getUri<Map<String, dynamic>>(any()),
        ).thenAnswer((_) async => response);

        final actual = await apiClient.getWeather(
          latitude: latitude,
          longitude: longitude,
        );

        expect(
          actual,
          isA<Weather>()
              .having((w) => w.temperature, 'temperature', 15.3)
              .having((w) => w.weatherCode, 'weathercode', 63.0),
        );
      });
    });
  });
}

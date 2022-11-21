// ignore_for_file: prefer_const_constructors

import 'package:open_meteo_api/open_meteo_api.dart';
import 'package:test/test.dart';

void main() {
  group('Weather', () {
    group('fromJson', () {
      test('returns correct Weather object', () {
        expect(
          Weather.fromJson(
            const {'temperature': 15.3, 'weathercode': 63},
          ),
          isA<Weather>()
              .having((w) => w.temperature, 'temperature', 15.3)
              .having((w) => w.weatherCode, 'weathercode', 63),
        );
      });
    });

    test('supports value comparison', () {
      expect(
        Weather(temperature: 15.3, weatherCode: 63),
        Weather(temperature: 15.3, weatherCode: 63),
      );

      expect(
        Weather(temperature: 15.3, weatherCode: 63) ==
            Weather(temperature: 15.3, weatherCode: 99),
        isFalse,
      );

      expect(
        Weather(temperature: 15.3, weatherCode: 63).hashCode,
        Weather(temperature: 15.3, weatherCode: 63).hashCode,
      );
    });

    test('supports copyWith', () {
      expect(
        Weather(temperature: 15.3, weatherCode: 63).copyWith(temperature: 999),
        Weather(temperature: 999, weatherCode: 63),
      );

      expect(
        Weather(temperature: 15.3, weatherCode: 63).copyWith(),
        Weather(temperature: 15.3, weatherCode: 63),
      );
    });
  });
}

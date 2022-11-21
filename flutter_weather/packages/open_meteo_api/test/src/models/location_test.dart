// ignore_for_file: prefer_const_constructors

import 'package:open_meteo_api/open_meteo_api.dart';
import 'package:test/test.dart';

void main() {
  group('Location', () {
    group('fromJson', () {
      test('returns correct Location object', () {
        expect(
          Location.fromJson(
            const {
              'id': 4887398,
              'name': 'Chicago',
              'latitude': 41.85003,
              'longitude': -87.65005,
            },
          ),
          isA<Location>()
              .having((l) => l.id, 'id', 4887398)
              .having((l) => l.name, 'name', 'Chicago')
              .having((l) => l.latitude, 'latitude', 41.85003)
              .having((l) => l.longitude, 'longitude', -87.65005),
        );
      });
    });

    test('supports value comparison', () {
      expect(
        Location(
          id: 4887398,
          name: 'Chicago',
          latitude: 41.85003,
          longitude: -87.65005,
        ),
        Location(
          id: 4887398,
          name: 'Chicago',
          latitude: 41.85003,
          longitude: -87.65005,
        ),
      );

      expect(
        Location(
              id: 4887398,
              name: 'Chicago',
              latitude: 41.85003,
              longitude: -87.65005,
            ) ==
            Location(
              id: 4887398,
              name: 'Chicago',
              latitude: 41.85003,
              longitude: 1,
            ),
        isFalse,
      );

      expect(
        Location(
          id: 4887398,
          name: 'Chicago',
          latitude: 41.85003,
          longitude: -87.65005,
        ).hashCode,
        Location(
          id: 4887398,
          name: 'Chicago',
          latitude: 41.85003,
          longitude: -87.65005,
        ).hashCode,
      );
    });

    test('supports copyWith', () {
      expect(
        Location(
          id: 4887398,
          name: 'Chicago',
          latitude: 41.85003,
          longitude: -87.65005,
        ).copyWith(id: 999),
        Location(
          id: 999,
          name: 'Chicago',
          latitude: 41.85003,
          longitude: -87.65005,
        ),
      );

      expect(
        Location(
          id: 4887398,
          name: 'Chicago',
          latitude: 41.85003,
          longitude: -87.65005,
        ).copyWith(),
        Location(
          id: 4887398,
          name: 'Chicago',
          latitude: 41.85003,
          longitude: -87.65005,
        ),
      );
    });
  });
}

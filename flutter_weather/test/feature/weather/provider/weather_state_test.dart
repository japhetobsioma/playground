// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/common/enum/enum.dart';
import 'package:flutter_weather/feature/weather/weather.dart';

void main() {
  group('WeatherState', () {
    final state1 = WeatherState(
      condition: WeatherCondition.clear,
      lastUpdated: DateTime(0),
      location: 'chicago',
      temperature: 42,
      temperatureUnits: TemperatureUnits.celsius,
    );
    final state2 = WeatherState(
      condition: WeatherCondition.clear,
      lastUpdated: DateTime(0),
      location: 'chicago',
      temperature: 42,
      temperatureUnits: TemperatureUnits.celsius,
    );

    test('supports copyWith', () {
      expect(state1.copyWith(temperature: 999).temperature, 999);

      expect(state1.copyWith(), state1);
    });

    test('supports value comparison', () {
      expect(state1, state2);

      expect(state1 == state2.copyWith(temperature: 999), isFalse);

      expect(state1.hashCode, state2.hashCode);
    });
  });
}

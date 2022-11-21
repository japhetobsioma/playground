import 'package:flutter/foundation.dart';
import 'package:flutter_weather/common/enum/enum.dart';

@immutable
class WeatherState {
  const WeatherState({
    required this.condition,
    required this.lastUpdated,
    required this.location,
    required this.temperature,
    required this.temperatureUnits,
  });

  final WeatherCondition condition;
  final DateTime lastUpdated;
  final String location;
  final double temperature;
  final TemperatureUnits temperatureUnits;

  WeatherState copyWith({
    WeatherCondition? condition,
    DateTime? lastUpdated,
    String? location,
    double? temperature,
    TemperatureUnits? temperatureUnits,
  }) {
    return WeatherState(
      condition: condition ?? this.condition,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
      temperature: temperature ?? this.temperature,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
    );
  }

  @override
  bool operator ==(covariant WeatherState other) {
    if (identical(this, other)) return true;

    return other.condition == condition &&
        other.lastUpdated == lastUpdated &&
        other.location == location &&
        other.temperature == temperature &&
        other.temperatureUnits == temperatureUnits;
  }

  @override
  int get hashCode {
    return condition.hashCode ^
        lastUpdated.hashCode ^
        location.hashCode ^
        temperature.hashCode ^
        temperatureUnits.hashCode;
  }
}

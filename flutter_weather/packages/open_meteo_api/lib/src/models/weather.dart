import 'package:meta/meta.dart';

@immutable
class Weather {
  const Weather({
    required this.temperature,
    required this.weatherCode,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['temperature'] as double,
      weatherCode: (json['weathercode'] as num).toDouble(),
    );
  }

  final double temperature;
  final double weatherCode;

  Weather copyWith({
    double? temperature,
    double? weatherCode,
  }) {
    return Weather(
      temperature: temperature ?? this.temperature,
      weatherCode: weatherCode ?? this.weatherCode,
    );
  }

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;

    return other.temperature == temperature && other.weatherCode == weatherCode;
  }

  @override
  int get hashCode => temperature.hashCode ^ weatherCode.hashCode;
}

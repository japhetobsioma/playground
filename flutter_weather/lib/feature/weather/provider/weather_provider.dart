import 'package:dio/dio.dart';
import 'package:flutter_weather/common/enum/enum.dart';
import 'package:flutter_weather/common/helper/helper.dart';
import 'package:flutter_weather/feature/weather/provider/weather_state.dart';
import 'package:flutter_weather/feature/weather/repository/repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_meteo_api/open_meteo_api.dart';

class WeatherNotifier extends StateNotifier<AsyncValue<WeatherState>> {
  WeatherNotifier({
    AsyncValue<WeatherState>? state,
    WeatherRepository? repository,
  })  : _repository = repository ?? WeatherRepository(),
        super(state ?? _initialState);

  static const _initialState = AsyncLoading<WeatherState>();

  final WeatherRepository _repository;

  Future<void> fetchWeather(String query) async {
    state = const AsyncLoading<WeatherState>();

    await Future<void>.delayed(const Duration(seconds: 3));

    await AsyncValue.guard(
      () async => _repository.getWeather(latitude: 123, longitude: 123),
    );
  }

  void toggleUnits() {
    final temperatureUnits = state.requireValue.temperatureUnits.isFahrenheit
        ? TemperatureUnits.celsius
        : TemperatureUnits.fahrenheit;
    final temperature = temperatureUnits.isCelsius
        ? state.requireValue.temperature.toCelsius()
        : state.requireValue.temperature.toFahrenheit();

    state = AsyncData(
      state.requireValue.copyWith(
        temperatureUnits: temperatureUnits,
        temperature: temperature,
      ),
    );
  }
}

final weatherProvider = StateNotifierProvider.autoDispose<WeatherNotifier,
    AsyncValue<WeatherState>>(
  (ref) {
    final cancelToken = CancelToken();
    ref.onDispose(
      cancelToken.cancel,
    );
    final client = Dio()
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            options.cancelToken = cancelToken;
          },
        ),
      );
    final apiClient = OpenMeteoApiClient(httpClient: client);
    final repository = WeatherRepository(apiClient: apiClient);

    return WeatherNotifier(repository: repository)..fetchWeather('Chicago');
  },
);

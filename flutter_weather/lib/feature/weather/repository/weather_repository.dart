import 'package:open_meteo_api/open_meteo_api.dart';

class WeatherRepository {
  WeatherRepository({
    OpenMeteoApiClient? apiClient,
  }) : _apiClient = apiClient ?? OpenMeteoApiClient();

  final OpenMeteoApiClient _apiClient;

  Future<Location> locationSearch(String query) async {
    return _apiClient.locationSearch(query);
  }

  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    return _apiClient.getWeather(
      latitude: latitude,
      longitude: longitude,
    );
  }
}

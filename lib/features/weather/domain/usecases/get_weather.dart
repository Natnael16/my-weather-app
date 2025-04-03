import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeather {
  final WeatherRepository repository;

  GetWeather(this.repository);

  /// Fetches weather data using the repository.
  Future<Weather> call(double lat, double lon) async {
    return await repository.getWeather(lat, lon);
  }
}

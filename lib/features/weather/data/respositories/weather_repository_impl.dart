// lib/data/repositories/weather_repository_impl.dart
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_datasource.dart';

/// Repository implementation using the [WeatherRemoteDataSource].
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<Weather> getWeather(double lat, double lon) async {
    final weatherModel = await remoteDataSource.fetchWeather(lat, lon);
    return weatherModel;
  }
}
